# CZ4010-Applied-Crypto

## Project Description
This project dealt with the implementation of a certification authority using RSA and elliptic curves as the encryption key and sha-256 as the hashing algorithm.  Firstly, a root certification authority (ca) is created. To implement trusting hierachies, and safegaurd the root CA, an intermediate CA is created automatically. This intermediate CA is used to sign other certification on the behalf of the root ca. Moreover, a simple console is created to allow hosts to view certificates, sign them and even revoke signatures.   

## How to install and run the project?
1. Go to openssl.cnf file and change the directory path to the location of your folder <br/>
2. Go to intermediate/openssl.cnf and change the directory path similar to step 1
3. Open terminal and grant permission for all files by running "chmod +x (file name)"

clone this repo <br />
go to openssl.cnf and change the dir name to your directory <br />
go to intermediate/openssl.cnf and change the dir name to your directory/intermediate <br />
open a terminal in the directory of the main repo <br />
chmod +x root_pair_automation.sh <br />
./root_pair_automation.sh <br />
enter details  <br />
<br />
cd intermediate <br />
./intermediate_automation.sh <br /> 
enter same details as last time, expect for common name. Needs a different common name <br />
<br />
cd .. <br />
./sign_cert_automation.sh <br />
 <br />
./revocation_automation.sh <br />
