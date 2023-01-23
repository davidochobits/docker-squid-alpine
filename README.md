Squid
=====

Slim image (19MB) of Squid 5.7-r0 running under Alpine Linux 3.17.1 for 32 bits


How to use
=========

```
docker run -p 3128:3128 davidpenya77/squid:arm32
```

With bespoke configuration:

```
docker run  -v <configPath>/squid.conf:/etc/squid/squid.conf:ro \
            -v <configPath/cache:/var/cache/squid:rw \
            -v /var/log/squid:/var/log/squid:rw \
            -v /etc/localtime:/etc/localtime:ro \
            -p 3128:3128 \
            davidpenya77/squid:arm32
```
