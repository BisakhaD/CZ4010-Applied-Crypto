# Implementing a Certification Authority
<img width="979" alt="image" src="https://user-images.githubusercontent.com/56753634/143765079-d488ed30-78ae-4024-83c6-6715f05b90d3.png">

## Project Description
This project deals with the implementation of a certification authority using RSA and Elliptic Curves (EC) as the encryption key and SHA-256 as the hashing algorithm. Firstly, a root certification authority (CA) is created. To implement trusting hierarchies, and safeguard the root CA, the host is prompted to create an intermediate CA automatically. This intermediate CA is used to sign other certifications on the behalf of the root ca. Moreover, a simple console is created to allow hosts to easily access the various functions and actions they can perform such as viewing certificates, signing them and even revoking signatures. 

There are 2 roles and databases involved in this project - client and host. The client can both create a certificate they would like a signature for and verify a certificate was signed by the CA. Once the client creates a certificate that requires a signature, they send a request for signature to the host. The host has to first create a root and intermediate CA. The root CA certificate is a self-signed certificate. Thus, the issuer and subject will be the same for this certificate. However,  the intermediate CA certificate will be signed by the root CA certificate. Upon the creation of root and intermediate CA, the intermediate CA can be used to sign the required certificates. Additionally, upon signing a certificate, the host can even revoke the signature. This will be updated in the database accordingly. The image below details the various actions of the CA.  
<img width="1018" alt="image" src="https://user-images.githubusercontent.com/56753634/143765126-a774096e-6043-4874-89cf-2e47b370e3b1.png">

The client has to run the **client.sh file** and the host runs the **main.sh** file. 

To explain, how our project works in layman terms we came up with an analogy. Hope you like it ;) 

BD is a girl who is forgetful and someone who cannot keep secrets, whereas AS is someone who loves keeping secrets and never forgets them. One day, BD hears of gossip and wishes to verify whether the information she has heard can be considered as 'gossip'. Thus, she tells this information to AS who verifies if the information can be considered as gossip. Once AS hears the information and realises it is in fact gossip she gives a thumbs up to BD approving her information as gossip. This is exactly how our project works as well. BD is the client in this story and AS is the CA. 

## Motivations
CZ4010 Applied Cryptography was our introduction to the field of cryptography or computer security in general. Prior to this course, we had a very rudimentary understanding of computer security and thus this course was a huge challenge itself. We chose this course in an attempt to try something new together, and have fun learning about the world of cryptography. While we were fascinated by all the new concepts we have learnt in this course, something that instantly captivated us was the Diffie-Hellman Key Exchange taught to us in Week 8 of this course. Building upon those concepts we were later introduced to RSA and EC as well. Even as we were watching the lectures, we knew we wanted to experiment with these ideas and see what we could come up with. This is one of the main reasons we decided to pursue the idea of implementing a certification authority. 

At first, we decided to diverge beyond the course curriculum and try different encryption keys. However, after comprehensive background research, we realised that RSA and EC would be our best choice. This is owing to a number of factors, including the fact that they are well-established, generally compatible, and easy to apply. Below are a few pointers on why we chose the following encryption keys:

<img width="976" alt="image" src="https://user-images.githubusercontent.com/56753634/143766074-6a2d2036-b22d-42b8-b0dc-e59f7d915344.png">

We also understood that there was no better way to show off our newfound expertise from this course than to apply it to our project.

## Research
**Confidentiality**, **Integrity**, **Non-repudiation** and **Authentication** are critical concepts revolving around computer security. Public Key Infrastructure (PKI) is a system that achieves the aforementioned security services. Thus, the goal of this project was to implement a certification authority system that can generate and distribute public key certificates. Certification Authority is an entity that issues digital certificates as a validation of the client???s identity. Without this, anything done online will be unsafe and all data entered on an online web service can be obtained by hackers. Every year, millions of digital certificates are issued by certification authorities. Typically, the certificate authorities must fulfill rigorous requirements to get approval from browsers, operating systems and other digital platforms. Upon this approval, any digital certificate signed by this CA is openly trusted. However, the CA does a few checks regarding the identity of the client before signing their certificate. 

<img width="655" alt="image" src="https://user-images.githubusercontent.com/56753634/143767104-3e7801a3-fa66-4d2b-a29a-a771a450f2c3.png">

CAs usually have a root CA certificate. However, this root CA certificate will not be used to sign server or client certificates and instead will be used to create one or more intermediate CAs, which are trusted by the root CA to sign certificates on their behalf. This ensures the safety of the root CA and prevents any compromise of the root key as this way it could be kept offline and unused. This hierarchy in certificates is called a trusting hierarchy. 

These certificates created by the CA usually employ the Rivest???Shamir???Adleman (RSA) algorithm, which is based on the factorization of large numbers. Another popular encryption algorithm that is gaining prominence is the elliptic curve encryption algorithm. The elliptic curve algorithm is based on a cube equation and provides stronger security than RSA for a substantially smaller key length. Though other encryption algorithms were researched during the course of this project, as mentioned in motivations, we finally went ahead with RSA and Elliptic Curves.

## Design and Development
The entire application was developed using the **shell** **script**. OpenSSL, a free and open-source library with a number of command-line utilities for working with digital certificates, was used in the development. 

As mentioned earlier, this project was designed with 2 roles in mind - **certification authority** and **client**. Thus the project has 2 databases, one for the client and the other for the host. 

Acting as a certificate authority (CA) means dealing with cryptographic pairs of private keys and public certificates. Firstly the root key and certificate pair was created, which acted as the identity of the root CA. However, the root CA does not sign any server or client certificates directly. The root CA is utilised to create one or more intermediate or subordinate CAs, which signs on their behalf. This is the best practice as it allows the root CA to be kept offline and unused as much as the possible, as any compromise of the root key can end up being catastrophic. Therefore, trusting hierarchies were implemented by prompting the user to create an intermediate CA certificate instantly upon the creation of a root CA certificate. The root CA gives the signature for the intermediate CA. Thereafter, all certificate signing requests are fulfilled by the intermediate CA. This can be seen in the screenshot below. 

<img width="776" alt="image" src="https://user-images.githubusercontent.com/56753634/143767203-aee43d65-599c-4786-abf5-0a3583468a87.png">

The client/CA are given a choice regarding the encryption key - Rivest???Shamir???Adleman (**RSA**) and Elliptic Curve (**EC**). Both the keys are implemented along with Advanced Encryption Standard 256 (**AES-256**). For the EC encryption key, we have implemented the prime256v1 elliptic curve as it is one of the most interoperable and supports a wide range of clients. Further, Secure Hash Algorithm 256 (**SHA-256**) was used as the hashing algorithm due to its secure characteristics such as having an avalanche effect where a small change in original data leads to a large change in hash value such that the similarity between data cannot be identified. 

### Role of a CA:
1. Create a root and intermediate CA by running <br/>  ``` ./main.sh  ```
2. For the creation of root and intermediate CA certificates, the host can select their choice of the encryption key (RSA/EC) and will then have to set up passwords for each of them and choose the time period of validity (e.g: 3750 days will be 10 years of validity). Certain conditions which are required to be met:
    - The expiry of the intermediate CA certificate should be earlier than the root CA. If the user types a longer time period of validity for the intermediate CA certificate in comparison to the root CA certificate, the system will automatically set the validity of the intermediate CA certificate to that of the root CA certificate. 
    - The details of the intermediate CA should match those of the root CA (such as country and organisation names), except for the common name, which must be different. 
    - For the generation of the intermediate CA certificate, a signature from the root CA certificate is required.   
4. Upon creation of a root and intermediate CA certificate, these are the following actions a host can perform:
    - Check if the chain of command is intact
    - View all certificates
    - Sign a certificate
    - Revoke a signature

### Role of a Client:
1. Create a certificate to be signed; Similar to the host, the client can also choose an encryption key between RSA and EC. They will also have to set up passwords, select a validity period and enter some details such as the country code, state, locality, common name etc. While some of these fields such as common names are necessary some of them can be skipped. Additionally, the client has to also provide a domain name for their certificate. 
2. Verify a certificate was signed by a CA; the client can just type the domain name of the certificate and verify if it has been signed by the CA. 

Example of verying whether a certificate was signed by the CA has been shown below:
<img width="621" alt="image" src="https://user-images.githubusercontent.com/56753634/143767656-d0bf9e44-5155-4915-ad6f-8fabbc03b158.png">

### The files in this github repository & what they do:
The primary files present in the Github Repo are:
1. **main.sh** : file to be run by the CAs.
2. **client.sh** : file to be run by the client.
3. **purpose.sh** : entails actions that can be performed by the CAs. The main.sh file calls upon this file once the root and intermediate CA certificates are created.
4. **root_pair_automation.sh** : file to create the root CA. The main.sh file calls this file during the creation of the root CA certificate.
5. **intermediate/intermediate_automation.sh** : file to create the intermediate CA. The main.sh file calls this file while creating the intermediate CA certificate.
6. **gen_cert_client.sh** : file to create a certificate signing request. The client.sh file calls upon this file while creating a certificate signing request.
7. **sign_cert_automation.sh** : file for signing a certificate on the CA side. The purpose.sh file calls this file when the host choses to sign a certificate. The client's certificate signing request files are shared with the CA accordingly.
8. **revocation_automation.sh** : file for revoking a signature. The purpose.sh file calls this file while the host selects to revoke a signature. 

### How to install and run the project?
1. Clone the repository
2. Go to the **openssl.cnf** file and change the directory path to the location of your folder <br/>
3. Go to **intermediate/openssl.cnf** and change the directory path similar to step 2 <br/>
4. Open terminal and grant permission for the files by running **chmod +x (file name)**. For example for the **main.sh** file the command would be: <br/> ``` chmod +x ./main.sh ``` <br />
5. If one wants to create a CA, they can run ``` ./main.sh  ```, else if they want to enter as a client, they can run ``` ./client.sh  ```

### Some test case examples 
This project is fully functional, to the extent tested by us. If you are able to find ways for us to improve, please do not hesitate to drop us an email at [**bisakha001@e.ntu.edu.sg**](mailto:bisakha001@e.ntu.edu.sg?subject=[GitHub]%20CZ4010%20Applied%20Crypto) or [**ahkshara001@e.ntu.edu.sg**](mailto:ahkshara001@e.ntu.edu.sg), so that we can learn from our mistakes :)

Here we have tried to list down some of the edge error cases:
1. Initializing intermediate expiry date as longer than that of root CA
    <img width="637" alt="image" src="https://user-images.githubusercontent.com/56753634/143768024-3d971745-93b3-408d-91a9-afd762e27b1b.png">
2. Proving a password that is too small
    <img width="944" alt="image" src="https://user-images.githubusercontent.com/56753634/143767978-bc081f56-ba25-43c7-8343-e6ad5bf99ebf.png">
3. Trying to sign an invalid certificate (non-existant, aldready-signed or revoked)
    <img width="503" alt="image" src="https://user-images.githubusercontent.com/56753634/143767880-9ed6e75c-9b07-4d73-b659-0ab5a8c43263.png">
4. Revoking a signature that doesn't exist
    <img width="1099" alt="image" src="https://user-images.githubusercontent.com/56753634/143768143-550838b8-c35c-4834-8ca6-7b415e6f9de2.png">

## What makes our project unique?
1. Simple console - the user (host/client) can easily access all the actions they wish to perform.
2. Autonomy for the users - Both the host and client have a choice regarding the encryption key. They can choose between an RSA or EC encryption key. Moreover, the user can decide how long they would like their certificate to be valid.
3. Trusting Hierarchy - Upon the creation of the root CA certificate, the console instantly prompts the host to create an intermediate CA certificate. This ensures the safety of the root CA certificate. 
4. Informative Messages - The entire console is filled with informative messages that guide the user throughout making the application user friendly. 


## References 
1: Aas, Josh, et al. "Let's Encrypt: an automated certificate authority to encrypt the entire web." Proceedings of the 2019 ACM SIGSAC Conference on Computer and Communications Security. 2019. <br/>
2: Al-Janabi, Sufyan Faraj, and Amer Kais Obaid. "Development of certificate authority services for web applications." 2012 International Conference on Future Communication Networks. IEEE, 2012.  <br/>
3: Dong, Y., et al. "Providing distributed certificate authority service in mobile ad hoc networks." First International Conference on Security and Privacy for Emerging Areas in Communications Networks (SECURECOMM'05). IEEE, 2005.  <br/>
4: Cano, Maria-Dolores, Ruben Toledo-Valera, and Fernando Cerdan. "A certification authority for elliptic curve X. 509v3 certificates." International Conference on Networking and Services (ICNS'07). IEEE, 2007.  <br/>
5: OpenSSL Foundation, I. (n.d.). OpenSSL. /index.html. Retrieved November 28, 2021, from https://www.openssl.org/. <br/>
