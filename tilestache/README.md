Here's an example of how to run a bare-bones TileStache server (on port 8080)
from the command-line. NOTE: this must be run from the root watercolor directory, not from watercolor/tilestache/.

	tilestache-server.py -c tilestache/tilestache.cfg

Note that this will bind to 127.0.0.1, and will only be accessible from the local machine. If you have root access, use sudo to bind to 0.0.0.0 and port 80:

	sudo tilestache-server.py -c tilestache/tilestache.cfg -i 0.0.0.0 -p 80

Here's an example of how to run TileStache under gunicorn:

    gunicorn -b 0.0.0.0:8080 "TileStache:WSGITileServer('tilestache/tilestache.cfg')"
    
Or more complicated:

	/usr/local/bin/gunicorn -n tilespotting -w 4 -u www-data -k egg:gunicorn#gevent_wsgi -b localhost:81 -D "TileStache:WSGITileServer('tilestache.cfg')"

-n	sets the name for the process 

-w	is the number of workers

-u	changes the process to run as this user

-k	sets the type of workers to use

-b	sets the address to bind

-D	is a flag to daemonize the process
