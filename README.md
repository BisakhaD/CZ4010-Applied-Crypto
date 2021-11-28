# CZ4010-Applied-Crypto

## Project Description
This project dealt with the implementation of a certification authority using RSA and Elliptic Curves (EC) as the encryption key and SHA-256 as the hashing algorithm.  Firstly, a root certification authority (CA) is created. To implement trusting hierachies, and safegaurd the root CA, the host is prompted to create an intermediate CA automatically. This intermediate CA is used to sign other certification on the behalf of the root ca. Moreover, a simple console is created to allow hosts to easily access the various functions and actions they can perform such as viewing certificates, sign them and even revoking signatures. 

There are 2 roles and databases involved in this project - client and host. The client can both create a certificate they would like a signature for and verify a certificate was signed by the CA. Once the client creates a certificate that requires a signature, they send a request for signature to the host. The host has to first create a root and intermediate CA. The root CA certificate is a self-signed certificate. Thus, the issuer and subject will be the same for this certificate. However,  the intermediate CA certificate will be signed by the root CA certificate. Upon the creation of root and intermediate CA, the intermediate CA can be used to sign the required certificates. Additionally upon signing a certificate, the host can even revoke the signature. This will be updated in the database accordingly.  

The client has to run the **client.sh file** and the host runs the **main.sh** file. 

## How to install and run the project?
1. Go to openssl.cnf file and change the directory path to the location of your folder <br/>
2. Go to intermediate/openssl.cnf and change the directory path similar to step 1
4. Open terminal and grant permission for all files by running **chmod +x (file name)**. For example for the **main.sh** file the command would be: <br/> ``` chmod +x ./main.sh ``` <br />
5. Follow the following instructions based on the role you choose:

### Role of a Host:
1. Create a root and intermediate CA by running <br/>  ``` ./main.sh  ```
2. For the creation of a root and intermediate CA certificates, you will have to set-up passwords for each of them and choose the time period of validity (e.g: 3750 days will be 10 years of validity). The expiry of the intermediate CA certificate should be earlier than the root CA. If the host types a longer time period of validity for the intermediate CA certificate in comparison to the root CA certificate, the system will automatically set the validity of the intermediate CA certificate to that of the root CA certificate.
3. For the generation of the intermediate CA certificate, a signature from the root CA certificate is required.   
4. Upon creation of a root and intermediate CA certificate, these are the following actions a host can perform:
    - Check of the chain of command is intact
    - View all certificates
    - Sign a certificate
    - Revoke a signature

### Role of a Client:
1. Create a certificate to be signed
2. Verify a certificate was signed by a CA 

## The files in the repo & what they do:
(in progress)

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
