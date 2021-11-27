#!/bin/bash

echo "Please name the domain you would like to be signed (eg. Bob.com)"
read name

mv bob/www.${name}.csr.pem intermediate/csr/www.${name}.csr.pem
mv bob/www.${name}.key.pem intermediate/private/www.${name}.key.pem

chmod 400 intermediate/private/www.${name}.key.pem

openssl req -config intermediate/openssl.cnf -key intermediate/private/www.${name}.key.pem -new -sha256 -out intermediate/csr/www.${name}.csr.pem

openssl ca -config intermediate/openssl.cnf -extensions server_cert -days 375 -notext -md sha256 -in intermediate/csr/www.${name}.csr.pem -out intermediate/certs/www.${name}.cert.pem

openssl x509 -noout -text -in intermediate/certs/www.${name}.cert.pem

openssl verify -CAfile intermediate/certs/ca-chain.cert.pem intermediate/certs/www.${name}.cert.pem