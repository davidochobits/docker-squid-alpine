# Squid proxy sobre Alpine Linux
# La versión de Squid viene fijada por Alpine (3.22 -> Squid 6.12)
FROM alpine:3.22

LABEL org.opencontainers.image.authors="davidochobits@protonmail.com" \
      org.opencontainers.image.source="https://github.com/davidochobits/docker-squid-alpine" \
      org.opencontainers.image.description="Squid proxy on Alpine Linux" \
      org.opencontainers.image.licenses="MIT"

RUN apk add --no-cache squid ca-certificates

COPY --chmod=755 start-squid.sh /usr/local/bin/start-squid.sh

EXPOSE 3128

# Verifica que el proceso squid responde y que la config es válida
HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
  CMD squid -k check || exit 1

ENTRYPOINT ["/usr/local/bin/start-squid.sh"]
