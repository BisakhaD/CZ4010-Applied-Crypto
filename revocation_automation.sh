openssl ca -config intermediate/openssl.cnf -gencrl -out intermediate/crl/intermediate.crl.pem

openssl crl -in intermediate/crl/intermediate.crl.pem -noout -text

mkdir bob
cd bob

openssl genrsa -out bob@example.com.key.pem 2048
openssl req -new -key bob@example.com.key.pem -out bob@example.com.csr.pem

mv bob/bob@example.com.csr.pem intermediate/csr/bob@example.com.csr.pem

cd ..
openssl ca -config intermediate/openssl.cnf -extensions usr_cert -notext -md sha256 -in intermediate/csr/bob@example.com.csr.pem -out intermediate/certs/bob@example.com.cert.pem

openssl verify -CAfile intermediate/certs/ca-chain.cert.pem intermediate/certs/bob@example.com.cert.pem

openssl ca -config intermediate/openssl.cnf -revoke intermediate/certs/bob@example.com.cert.pem

# Recreating the crl after revoking bob
openssl ca -config intermediate/openssl.cnf -gencrl -out intermediate/crl/intermediate.crl.pem
