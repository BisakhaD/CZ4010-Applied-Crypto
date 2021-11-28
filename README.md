# CZ4010 Applied Cryptography - Implementing a Certification Authority

## Project Description
This project deals with the implementation of a certification authority using RSA and Elliptic Curves (EC) as the encryption key and SHA-256 as the hashing algorithm.  Firstly, a root certification authority (CA) is created. To implement trusting hierachies, and safegaurd the root CA, the host is prompted to create an intermediate CA automatically. This intermediate CA is used to sign other certification on the behalf of the root ca. Moreover, a simple console is created to allow hosts to easily access the various functions and actions they can perform such as viewing certificates, sign them and even revoking signatures. 

There are 2 roles and databases involved in this project - client and host. The client can both create a certificate they would like a signature for and verify a certificate was signed by the CA. Once the client creates a certificate that requires a signature, they send a request for signature to the host. The host has to first create a root and intermediate CA. The root CA certificate is a self-signed certificate. Thus, the issuer and subject will be the same for this certificate. However,  the intermediate CA certificate will be signed by the root CA certificate. Upon the creation of root and intermediate CA, the intermediate CA can be used to sign the required certificates. Additionally upon signing a certificate, the host can even revoke the signature. This will be updated in the database accordingly.  

The client has to run the **client.sh file** and the host runs the **main.sh** file. 

## How to install and run the project?
1. Clone the repository
2. Go to the **openssl.cnf** file and change the directory path to the location of your folder <br/>
3. Go to **intermediate/openssl.cnf** and change the directory path similar to step 1
4. Open terminal and grant permission for all files by running **chmod +x (file name)**. For example for the **main.sh** file the command would be: <br/> ``` chmod +x ./main.sh ``` <br />
5. Follow the following instructions based on the role you choose:


### Role of a Host:
1. Create a root and intermediate CA by running <br/>  ``` ./main.sh  ```
2. For the creation of a root and intermediate CA certificates, the host can select their choice of encryption key (RSA/EC) and will then have to set-up passwords for each of them and choose the time period of validity (e.g: 3750 days will be 10 years of validity). The expiry of the intermediate CA certificate should be earlier than the root CA. If the host types a longer time period of validity for the intermediate CA certificate in comparison to the root CA certificate, the system will automatically set the validity of the intermediate CA certificate to that of the root CA certificate. For the generation of the intermediate CA certificate, a signature from the root CA certificate is required.   
3. Upon creation of a root and intermediate CA certificate, these are the following actions a host can perform:
    - Check of the chain of command is intact
    - View all certificates
    - Sign a certificate
    - Revoke a signature


### Role of a Client:
1. Create a certificate to be signed; Similar to the host, the client can also choose an encryption key between RSA and EC. They will also have to set up passwords, select a validity period and enter some details such as the country code, state, locality, common name etc. While some of these fields such as common name are neccessary some of them can be skipped. Additionally, the client has to also provide a domain name for their certificate. 
3. Verify a certificate was signed by a CA; the client can just type the domain name of the certifiate and verify if it has been signed by the CA. 


## The files in the repo & what they do:
The primary files present in the github repo are:
1. **main.sh** : file to be run by the host.
2. **client.sh** : file to be run by the client.
3. **purpose.sh** : entails actions that can be performed by the host. The main.sh file calls upon this file once the root and intermediate CA certificates are created.
4. **root_pair_automation.sh** : file to create the root CA. The main.sh file calls this file during the creation of the root CA certificate.
5. **intermediate/intermediate_automation.sh** : file to create the intermediate CA. The main.sh file calls this file while creating the intermediate CA certificate.
6. **gen_cert_client.sh** : file to create a certificate signing request. The client.sh file calls upon this file while creating a certificate.
7. **sign_cert_automation.sh** : file for signing a certificate on the host side. The purpose.sh file calls this file when the host choses to sign a certificate.
8. **revocation_automation.sh** : file for revoking a signature. The purpose.sh file calls this file while the host selects to revoke a signature. 


