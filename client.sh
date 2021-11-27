#!/bin/bash

echo Please select one of the options you would like to perform
echo 1. create a certificate to be signed
echo 2. verify certificate was signed by CA
read action

if [ "$action" == "1" ]; then
	chmod +x gen_cert_client.sh
	./gen_cert_client.sh
else
	echo "Please enter the name of the domain you would like to verify (eg. Bob.com)"
	read domain_name
	cd intermediate
	openssl x509 -noout -text -in certs/www.${domain_name}.cert.pem
fi