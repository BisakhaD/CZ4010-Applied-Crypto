#!/bin/bash

echo ----------- Root and Intermediate CA Pairs Created-----------

#purpose
for i in {0..10}
do
	echo Please indicate your preferred action
	echo 1. Check if chain of command is intact
	echo 2. View the certificates
	echo 3. Sign a certificate
	echo 4. Revoke a signature
	echo 5. Exit
	read ca_auth

	if [ "$ca_auth" == "1" ]; then
		echo Checking if chain of command between root and intermediate CA is intact:
		openssl verify -CAfile certs/ca.cert.pem intermediate/certs/intermediate.cert.pem
	elif [ "$ca_auth" == "2" ]; then
		echo "Certificated signed by root CA:"
		cat index.txt ; echo
		echo "Certificated signed by intermediate CA:"
		cat intermediate/index.txt ; echo
	elif [ "$ca_auth" == "3" ]; then
		export option
		./sign_cert_automation.sh
	elif [ "$ca_auth" == "4" ]; then
		echo "Please enter the name of the domain you would like to revoke (eg. Bob.com)"
		read rev_name
		export option rev_name
		./revocation_automation.sh
	else
		break
	fi
done

echo "Thank you for using this CA!"
