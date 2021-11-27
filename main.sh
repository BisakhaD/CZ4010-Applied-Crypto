#!/bin/bash

echo --------------------------------------------
echo     Welcome to Certification Authority
echo --------------------------------------------

echo Please begin by creating a new root and intermediate CA pairs

echo -----------Creating Root and Intermediate CA Pairs-----------

echo Which encryption key would you like to use?
echo Press 1 for RSA
echo Press 2 for EC
read option
if [ "$option" == "1" ];
then 
	echo Initiating root pair automation with RSA
	export option
	./root_pair_automation.sh
else
	echo Initiating root pair automation with EC
	export option
	./root_pair_automation.sh
fi