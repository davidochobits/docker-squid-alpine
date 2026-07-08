# Squid on Alpine Linux

Slim, multi-arch Docker image of [Squid](http://www.squid-cache.org/) proxy running on Alpine Linux.

- **Squid 6.x** on **Alpine 3.22**
- Multi-arch: `linux/amd64`, `linux/arm64`, `linux/arm/v7` (Raspberry Pi friendly)
- Built-in `HEALTHCHECK`
- Rebuilt weekly via GitHub Actions to pick up the latest Alpine security patches
- Images scanned with Trivy on every build

## Tags

| Tag | Description |
|-----|-------------|
| `latest` | Latest build from `master` |
| `6.12` | Pinned to a specific Squid version |
| `6.12-YYYYMMDD` | Weekly dated build, for reproducible deployments |

Available on [Docker Hub](https://hub.docker.com/r/davidpenya77/squid) and GHCR (`ghcr.io/davidochobits/squid`).

## Quick start

```bash
docker run -d -p 3128:3128 davidpenya77/squid
```

Test it:

```bash
curl -x http://localhost:3128 http://example.com
```

## With your own configuration

```bash
docker run -d \
  -v ./config/squid.conf:/etc/squid/squid.conf:ro \
  -v squid-cache:/var/cache/squid \
  -v /etc/localtime:/etc/localtime:ro \
  -p 3128:3128 \
  davidpenya77/squid
```

Or with Docker Compose (see [`docker-compose.yaml`](docker-compose.yaml)):

```bash
docker compose up -d
```

> **Note:** make sure the ACLs in your `squid.conf` (`acl localnet src ...` /
> `http_access`) match your network, and that it ends with `http_access deny all`.

## Logs

Squid runs in the foreground with debug level 1, so:

```bash
docker logs -f squid
```

## Building locally

```bash
docker build -t squid .
```

## Kubernetes (Helm)

```bash
helm install squid oci://ghcr.io/davidochobits/charts/squid \
  --set config.allowedCidrs={10.0.0.0/8}
```

See [charts/squid/values.yaml](charts/squid/values.yaml) for all options.

## Credits

Originally forked from an unlicensed, now unmaintained repository. This
version has been fully rewritten and modernized (Alpine 3.22, Squid 6,
healthcheck, multi-arch CI).

## License

[MIT](LICENSE)
