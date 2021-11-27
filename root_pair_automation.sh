#!/bin/bash

mkdir certs crl newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial

echo creating root CA key

if [ "$option" == "1" ]; then
	openssl genrsa -aes256 -out private/ca.key.pem 4096
else
	openssl ecparam -genkey -name prime256v1 -out private/ca_temp.key.pem
	openssl ec -in private/ca_temp.key.pem -out private/ca.key.pem -aes256
fi

chmod 400 private/ca.key.pem

echo Root CA key created ; echo
echo Creating Root CA Certificate ; echo

echo -n How many days would you like to set as the date of expiry?
read exp

echo

openssl req -config openssl.cnf -key private/ca.key.pem -new -x509 -days $exp -sha256 -extensions v3_ca -out certs/ca.cert.pem

chmod 444 certs/ca.cert.pem

echo
echo
echo Verifying the root CA certificate ; echo ; echo

openssl x509 -noout -text -in certs/ca.cert.pem

echo
echo ------ Root CA authorised ------ ; echo
echo Creating Intermediate CA
echo
cd intermediate
chmod +x intermediate_automation.sh
export exp option
./intermediate_automation.sh

