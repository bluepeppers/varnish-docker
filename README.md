Automated build of Varnish with Docker
===========

Think.. what if we used varnish instead of socat in the ambassador image?

    $ docker run --rm -P --link endpoint:endpoint bluepeppers/varnish

Voila, caching your http endpoint with the default varnish config.

TODO
----

Allow something that isn't the default varnish config in a semi graceful manner.
