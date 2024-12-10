#!/bin/bash

mkdir -p $CRT_PATH
if [ ! -f $CRT_KEY_PATH ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
        -keyout $CRT_KEY_PATH \
        -out $CRT_CRT_PATH \
        -subj $CRT_CREDENTIALS;
fi

sed -i "s|crt_here|$CRT_KEY_PATH|g" $CRT_DEFAULT_PATH
sed -i "s|key_here|$CRT_CRT_PATH|g" $CRT_DEFAULT_PATH
sed -i "s|server_name_here|$WP_URL|g" $CRT_DEFAULT_PATH

exec "$@"
