#!/bin/sh

messagefile=$1
signaturefile=$2

if [ -f private-key.pem ] && [ -f public-key.pem ]; then
	if [ -n "$messagefile" ] && [ -n "$signaturefile" ]; then
		openssl dgst -sha256 -sign private-key.pem -passin pass:secretpassword -out message.sha256 $messagefile
		./jwt-base64-encrypt.sh message.sha256 > $signaturefile
		rm -rf message.sha256
	else
		echo "jwt-create-signature: invalid arguments - [messagefile] [signaturefile]"
	fi
else
	echo "jwt-create-signature: key pair missing - run 'create-keys' to generate a new key pair"
fi
