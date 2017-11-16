#!/bin/sh

rawheaderfile=$1
rawclaimsfile=$2
clientassertionfile=$3

if [ -f private-key.pem ] && [ -f public-key.pem ]; then
	if  [ -n "$rawheaderfile" ] && [ -n "$rawclaimsfile" ] && [ -n "$clientassertionfile" ]; then
		cat $rawheaderfile | tr -d "\n" | ./jwt-base64-encrypt.sh > message.txt
		echo -n "." >> message.txt
		cat $rawclaimsfile | tr -d "\n" | ./jwt-base64-encrypt.sh >> message.txt

		./jwt-create-signature.sh message.txt signature.bin
		./jwt-verify-signature.sh signature.bin message.txt

		cat message.txt | tr -d "\n" > $clientassertionfile
		echo -n "." >> $clientassertionfile
		cat signature.bin | tr -d "\n" >> $clientassertionfile
		
		rm -rf message.txt
		rm -rf signature.bin
	else
		echo "jwt-create-client-assertion: invalid arguments - [rawheaderfile] [rawclaimsfile] [clientassertionfile]"
	fi
else
	echo "jwt-create-client-assertion: key pair missing - run 'create-keys' to generate a new key pair"
fi
