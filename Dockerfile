FROM alpine:latest AS build
RUN apk add \
        libcap-dev \
        libconfig-dev \
        pcre-dev \
        gcc \
        make \
        musl-dev

COPY . /src
WORKDIR /src
RUN make CFLAGS='-Wall -Os' ENABLE_REGEX=1 LIBCONFIG=1 LIBCAP=1 LIBPCRE=1 -W sslh-conf.c

FROM alpine:latest AS sslh
ENV SSLH_MODE=fork
RUN apk add \
        libcap \
        libconfig \
        pcre

COPY --from=build /src/sslh-fork /src/sslh-select /
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
