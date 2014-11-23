Automated build of Varnish with Docker
===========

Think.. what if we used varnish instead of socat in the ambassador image?

    $ docker run --rm --name endpoint_cache -P --link endpoint:endpoint bluepeppers/varnish

Voila, caching your http endpoint with the default varnish config:

    $ time curl $(docker port endpoint_cache 80)/some/slow/endpoint -o /dev/null
    real    0m30.838s
    user    0m0.022s
    sys     0m0.015s
    $ time curl $(docker port endpoint_cache 80)/some/slow/endpoint -o /dev/null
    real    0m0.030s
    user    0m0.029s
    sys     0m0.001s

Of course, still doesn't excuse that endpoint taking 30 seconds, but, you know,
the demo's tomorrow! and the CEO just wants it working!

TODO
----

 - Allow something that isn't the default varnish config in a semi graceful manner.
 - Handle multiple backends?
 - Purging the cache (oh, so restarting it isn't good enough? eh?)
