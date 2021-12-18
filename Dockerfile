FROM alpine:latest
LABEL org.opencontainers.image.source=https://github.com/STRRL/backup-cronjob
RUN apk add --no-cache --purge bash zip
COPY ./backup-file-zip.sh /backup-file-zip.sh
CMD ["bash", "/backup-file-zip.sh"]
