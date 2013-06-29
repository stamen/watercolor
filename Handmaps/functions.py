from PIL import Image, ImageDraw, ImageFilter, ImageChops, ImageOps, ImageMath
from numpy import fromstring, ubyte, e, array, add, uint8, copy, clip
from scipy.ndimage.filters import convolve1d

def get_color_masks(image, colors):
    """ Accepts a PIL image and list of colors, returns a dictionary of channels.
    
        Colors is a list of strings like ["0xff9900", "0x990099", ...].
        
        Response is a dictionary of colors to numpy uint8 channel arrays.
    """
    mask_dict = {}

    channel_array = map(img2arr, image.split())

    for color in colors:

        fuzziness = 100
        
        truth_arrays = []

        for i in range(3):
            target = int(color, 0) >> (8 * (2 - i)) & 0xff
            t = []
            if target > 0x80:
                t = channel_array[i] > (target - fuzziness)
            else:
                t = channel_array[i] < (target + fuzziness)

            ##            print hex(color), i, target, target 
            truth_arrays.append(t)

        mask = truth_arrays[0] & truth_arrays[1] & truth_arrays[2]

        mask_dict[color] = mask * 0xff
        
    return  mask_dict

def gaussian(data, radius):
    """ Perform a gaussian blur on a data array representing an image.

        Manipulate the data array directly.

        Switching from numpy.convolve() to scipy's convolve1d() increased the
        speed of this function by 300% or so; trying a regular 2d convolution
        with scipy's convolve() made it significantly slower.
    """
    #
    # Build a convolution kernel based on
    # http://en.wikipedia.org/wiki/Gaussian_function#Two-dimensional_Gaussian_function
    #
    kernel = range(-radius, radius + 1)
    kernel = [(d ** 2) / (2 * (radius * .5) ** 2) for d in kernel]
    kernel = [e ** -d for d in kernel]
    kernel = array(kernel, dtype=float) / sum(kernel)
    
    #
    # Convolve on each axis sequentially.
    #
    convolve1d(data, kernel, output=data, axis=0)
    convolve1d(data, kernel, output=data, axis=1)

def usm(data, multiplier, radius, threshold):
    blur = 255 - copy(data) * .5
    gaussian(blur, radius)
    
    mask = add(data, blur) * .5

    mult_mask = (mask - 128) * 4 + 128

    ll = blend_channels_linear_light(data, mult_mask)
    return ll

def blend_channels_linear_light(bottom_chan, top_chan):
    """ Return combination of bottom and top channels.
    
        Math from http://illusions.hu/effectwiki/doku.php?id=linear_light_blending
    """
    return clip(bottom_chan[:,:] + 2 * top_chan[:,:] - 255, 0, 255)

def arr2img(ar):
    """ Convert Numeric array to PIL Image.
"""
    return Image.fromstring('L', (ar.shape[1], ar.shape[0]), ar.astype(ubyte).tostring())

def img2arr(im):
    """ Convert PIL Image to Numeric array.
"""
    return fromstring(im.tostring(), ubyte).reshape((im.size[1], im.size[0]))


class MyGaussianBlur(ImageFilter.Filter):
    name = "GaussianBlur"

    def __init__(self, radius=3):
        self.radius = radius
    def filter(self, image):
        return image.gaussian_blur(self.radius)

def get_shadows(image, radius, multiplier=1):
    alpha = image.convert("L")

    dat = img2arr(alpha)
    gaussian(dat, radius)
    maskblur = arr2img(dat)
    
    outline = ImageChops.add(maskblur, ImageOps.invert(alpha))
    outline = outline.point(lambda i: 255 - (255 - i) * multiplier)

    new_alpha = ImageChops.add(ImageOps.invert(outline), ImageOps.invert(alpha))
    m = Image.merge("RGBA", (outline, outline, outline, new_alpha))

    return m

def get_outlines(image, radius, multiplier=1):
    alpha = image.convert("L")
    
    dat = img2arr(ImageChops.invert(alpha))
    gaussian(dat, radius)
    maskblur = arr2img(dat)
    
    outline = ImageChops.add(alpha, maskblur)
    outline = outline.point(lambda i: 255 - (255 - i) * multiplier)

    new_alpha = ImageChops.add(ImageOps.invert(outline), ImageOps.invert(alpha))
    m = Image.merge("RGBA", (outline, outline, outline, new_alpha))

    return m

def get_outlines_even(image, radius, multiplier=1):
    alpha = image.convert("L")
    
    dat = img2arr(alpha)
    gaussian(dat, radius)
    maskblur = arr2img(dat)
    
    outline = ImageChops.add(alpha, ImageOps.invert(maskblur))

    maskblur = maskblur.convert("RGBA")
    maskblur.putalpha(ImageOps.invert(outline))

    white = Image.new("RGBA", maskblur.size, "#FFF")
    white.paste(maskblur, None, maskblur)
    final = white.point(lambda i: 255 - (255 - i) * multiplier)
    
    return final

def simplemask(artwork, display_texture, buffer_size):
    mask = ImageChops.invert(artwork.convert("L"))

    tex_layer = Image.new("RGBA", artwork.size)       
    for i in range(-1, (tex_layer.size[1] - buffer_size) / display_texture.size[1] + 1):
        for j in range(-1, (tex_layer.size[0] - buffer_size) / display_texture.size[1] + 1):
            tex_layer.paste(display_texture, (display_texture.size[0] * j, display_texture.size[1] * i))

    layers = tex_layer.split()

    comp = Image.merge("RGBA", (layers[0], layers[1], layers[2], mask))

##    comp = Image.merge("RGBA", (mask, mask, mask, mask))

    return comp 

def watercolorize(mask, edge_texture, display_texture, texture_offsets, buffer_size, edge_multiplier=.2, edge_gauss=6, edge_threshold=90, outline_gauss=15, outline_multiplier=.7, aa_mult=2):
##    print "using the right watercolorize:", buffer_size, edge_multiplier, edge_gauss, edge_threshold, outline_gauss, outline_multiplier, aa_mult
##    edge_texture = edge_texture.point(lambda k:int(k * edge_multiplier))

    ## tile the edger and texture as necessary to fit the mask
    edger_layer = Image.new("L", mask.size)
    for i in range(-1, (edger_layer.size[1] - buffer_size) / edge_texture.size[1] + 1):
        for j in range(-1, (edger_layer.size[0] - buffer_size) / edge_texture.size[1] + 1):
            edger_layer.paste(edge_texture,
                              (edge_texture.size[0] * j - texture_offsets[0] - buffer_size,
                               edge_texture.size[1] * i - texture_offsets[1] - buffer_size))

    tex_layer = Image.new("RGBA", mask.size)       
    for i in range(-1, (tex_layer.size[1] - buffer_size) / display_texture.size[1] + 1):
        for j in range(-1, (tex_layer.size[0] - buffer_size) / display_texture.size[1] + 1):
            tex_layer.paste(display_texture,
                            (display_texture.size[0] * j - texture_offsets[0] - buffer_size,
                             display_texture.size[1] * i - texture_offsets[1] - buffer_size))

    artwork = mask.convert("L")
    dat = img2arr(artwork)
    edg = img2arr(edger_layer)
    gaussian(dat, edge_gauss)

    dat = add(dat * (1 - edge_multiplier), edg * edge_multiplier)
    dat = (dat > edge_threshold).astype(uint8) * 255

    #blur, then unsharp mask to smooth pixelated edges
    gaussian(dat, 3)
    dat = usm(dat, 4, 15, 0)
    new_outline = arr2img(255 - dat)

    if outline_multiplier > 0:
        

        outlined = get_outlines_even(ImageOps.invert(new_outline), outline_gauss, outline_multiplier)

        old_bands = tex_layer.split()
        new_bands = []
        for i in range(3):
            band1 = ImageOps.invert(old_bands[i])
            band2 = outlined
            temp = ImageMath.eval("int(a/((float(b)+1)/256))", a=band1, b=band2).convert("L")
            new_bands.append(ImageOps.invert(temp))

        outlined = Image.merge("RGB", new_bands)

    else:
        outlined = tex_layer
    
    alpha_test = outlined.convert("RGBA")
    alpha_test.putalpha(new_outline)
    return alpha_test

##    final_image = Image.new("RGB", mask.size, "#FFFFFF")
##    final_image.paste(outlined, (0,0), new_outline)
##
##    return final_image

def generate_test_block(noise, layer):
    t = Image.open("textures/watercolor_" + layer + "1.png")
    a = Image.open("layers/watercolor_" + layer + "_small1.png")
    c = Image.new("RGB", (a.size[0] * 10 + 11, a.size[1] * 10 + 11), "#ffffff")
    for i in range(10):
        mult = .2
        thresh = (i + 1) * 20
        e = edger.point(lambda k: int(k * mult))
        for j in range(10):
            f = watercolorize(a, e, t, j * 2, thresh)
    ##        f.save("ground_test_" + str((i + 1) * 10) + "_" + str(j * 25) + ".png")
            c.paste(f, (f.size[0] * i + i, f.size[1] * j + j), f)

    return c
