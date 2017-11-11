#!/bin/sh

openssl genrsa -aes256 -passout pass:secretpassword -out private-key.pem 2048
openssl pkey -passin pass:secretpassword -in private-key.pem -pubout -out public-key.pem
