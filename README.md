# CZ4041-Applied-Crypto

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
