#!/bin/sh
case "${SSLH_MODE}" in
    select)
        SSLH="/sslh-select" ;;
    fork|*)
        SSLH="/sslh-fork" ;;
esac

if [ "${SSLH_OPTS}" ]; then
    "${SSLH}" -f ${SSLH_OPTS}
else
    exec "${SSLH}" "$@"
fi
