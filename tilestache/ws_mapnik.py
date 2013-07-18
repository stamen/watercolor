""" The world's tiniest Mapnik WMS server, playing just for you.

    Requires a TileStache configuration, and only tested with Mapnik provider.
"""

from urlparse import parse_qsl
from StringIO import StringIO

from TileStache import WSGITileServer
from TileStache.Core import KnownUnknown

class MapnikWSGIServer (WSGITileServer):
    """ Inherit the constructor from TileStache WSGI, which just loads
        a TileStache configuration file into self.config.
    """

    def __call__(self, environ, start_response):
        """ There are seven required CGI parameters:
            layer, width, height, xmin, ymin, xmax and ymax.
        """
        try:
            for var in 'QUERY_STRING PATH_INFO'.split():
                if var not in environ:
                    raise KnownUnknown('Missing "%s" environment variable' % var)
            
            query = dict(parse_qsl(environ['QUERY_STRING']))
            
            for param in 'width height xmin ymin xmax ymax'.split():
                if param not in query:
                    raise KnownUnknown('Missing "%s" parameter' % param)
            
            layer = environ['PATH_INFO'].strip('/')
            layer = self.config.layers[layer]
            provider = layer.provider
            
            width, height = [int(query[p]) for p in 'width height'.split()]
            xmin, ymin, xmax, ymax = [float(query[p]) for p in 'xmin ymin xmax ymax'.split()]
            
            #
            # TileStache Mapnik provider doesn't actually use the srs or zoom
            # arguments, so we can skip them entirely here for brevity.
            #
            # Other providers may flip out.
            #
            
            output = StringIO()
            image = provider.renderArea(width, height, None, xmin, ymin, xmax, ymax, None)
            image.save(output, format='PNG')
            
            start_response('200 OK', [('Content-Type', 'image/png')])
            return output.getvalue()
        
        except KnownUnknown, e:
            start_response('400 Bad Request', [('Content-Type', 'text/plain')])
            return str(e)
        
        except Exception, e:
            start_response('500 Internal Server Error', [('Content-Type', 'text/plain')])
            return str(e)
