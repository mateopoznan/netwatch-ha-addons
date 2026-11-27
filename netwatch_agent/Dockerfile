FROM ghcr.io/home-assistant/base:3.24
RUN apk add --no-cache curl ca-certificates
COPY run.sh /
RUN chmod a+x /run.sh
CMD ["/run.sh"]
