#!/bin/bash

openssl ca -config intermediate/openssl.cnf -gencrl -out intermediate/crl/intermediate.crl.pem

openssl crl -in intermediate/crl/intermediate.crl.pem -noout -text

#mv bob/www.${rev_name}.csr.pem intermediate/csr/www.${rev_name}.csr.pem

openssl ca -config intermediate/openssl.cnf -extensions usr_cert -notext -md sha256 -in intermediate/csr/www.${rev_name}.csr.pem -out intermediate/certs/www.${rev_name}.cert.pem

openssl verify -CAfile intermediate/certs/ca-chain.cert.pem intermediate/certs/www.${rev_name}.cert.pem

openssl ca -config intermediate/openssl.cnf -revoke intermediate/certs/www.${rev_name}.cert.pem

# Recreating the crl after revoking bob
openssl ca -config intermediate/openssl.cnf -gencrl -out intermediate/crl/intermediate.crl.pem
