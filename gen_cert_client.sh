#!/bin/bash

mkdir bob
cd bob

echo Which encryption key would you like to use?
echo Press 1 for RSA
echo Press 2 for EC
read option
echo

echo "Please enter the name of the certificate (eg. Bob.com)"
read name

if [ "$option" == "1" ]; then
	openssl genrsa -out www.${name}.key.pem 2048
else
	openssl ecparam -genkey -name prime256v1 -out www.${name}.key.pem
	openssl ec -in bob@example_temp.com.key.pem -out www.${name}.key.pem -aes256 
fi

openssl req -new -key www.${name}.key.pem -out www.${name}.csr.pem

cd ..
export name