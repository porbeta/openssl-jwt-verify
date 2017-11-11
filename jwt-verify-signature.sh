#!/bin/sh

signaturefile=$1
messagefile=$2

if [ -f private-key.pem ] && [ -f public-key.pem ]; then
	if [ -n "$messagefile" ] && [ -n "$signaturefile" ]; then
		./jwt-base64-decrypt.sh $signaturefile > decoded_signature.sha256
		openssl dgst -sha256 -verify public-key.pem -signature decoded_signature.sha256 $messagefile
		rm -rf decoded_signature.sha256
	else
		echo "jwt-signature-verify: invalid arguments - [messagefile] [signaturefile]"
	fi
else
	echo "jwt-signature-verify: key pair missing - run 'create-keys' to generate a new key pair"
fi
