mkdir certs crl csr newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial

echo 1000 > crlnumber

cd ..

echo Creating Intermediate CA key
if [ "$option" == "1" ]; then
	openssl genrsa -aes256 -out intermediate/private/intermediate.key.pem 4096
else
	openssl ecparam -genkey -name prime256v1 -out intermediate/private/intermediate_temp.key.pem
	openssl ec -in intermediate/private/intermediate_temp.key.pem -out intermediate/private/intermediate.key.pem -aes256
fi

chmod 400 intermediate/private/intermediate.key.pem

echo Intermediate CA key created
echo Creating Intermediate CA Certificate

openssl req -config intermediate/openssl.cnf -new -sha256 -key intermediate/private/intermediate.key.pem -out intermediate/csr/intermediate.csr.pem

echo -n How many days would you like to set as the date of expiry?
read exp_intermediate

if [ "$exp_intermediate" -gt "$exp" ]; then
	echo The expiry for the intermediate CA has been set as longer than the expiry for the root CA
	echo The expiry for the intermediate is being set to $exp as default
	openssl ca -config openssl.cnf -extensions v3_intermediate_ca -days $exp -notext -md sha256 -in intermediate/csr/intermediate.csr.pem -out intermediate/certs/intermediate.cert.pem
else
	openssl ca -config openssl.cnf -extensions v3_intermediate_ca -days $exp_intermediate -notext -md sha256 -in intermediate/csr/intermediate.csr.pem -out intermediate/certs/intermediate.cert.pem
fi

chmod 444 intermediate/certs/intermediate.cert.pem

# Verifing the intermediate certificate

openssl x509 -noout -text -in intermediate/certs/intermediate.cert.pem

# Checking if the chain of command is intact

openssl verify -CAfile certs/ca.cert.pem intermediate/certs/intermediate.cert.pem

# Creating the certificate chain file

cat intermediate/certs/intermediate.cert.pem certs/ca.cert.pem > intermediate/certs/ca-chain.cert.pem

chmod 444 intermediate/certs/ca-chain.cert.pem

pwd
chmod +x purpose.sh
export option
./purpose.sh
