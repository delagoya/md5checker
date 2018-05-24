FROM alpine:3.7

RUN apk update && apk add \
   util-linux \
   curl \
   && rm -f /var/cache/apk/*
COPY calc.sh /calc.sh

ENTRYPOINT ["/calc.sh"]
