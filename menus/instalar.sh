#!/usr/bin/env bash

read -r -d '' ENV_CONFIG << EOM
  Main Menu
  - Install
EOM
describe "Testing"
createMenu "menuInstall" "$ENV_CONFIG"
addMenuItem "menuInstall" "Centos 8 Cpanel"  init
addMenuItem "menuInstall" "Go back" loadMenu "mainMenu"

script(){
		echo -e "\033[32;94;5m
	#############################################################################
	- >                                 Iniciar                                 < -
	#############################################################################
		\033[m"
		echo -e "\033[32;94;2m
	_____________________________________________________________________________
	 [+] Trazendo a ajuda: includes/$1
	-----------------------------------------------------------------------------
		\033[m"


 wget https://raw.githubusercontent.com/TedLeRoy/first-ten-seconds-redhat-ubuntu/master/first-ten.sh
  chmod +x first-ten.sh
  ./first-ten.sh




			echo -e "\033[31;91;2m
	_____________________________________________________________________________
	 [+] Concluido...
	 [+] Registrando O Resultado em logs/$1.txt
	-----------------------------------------------------------------------------
		\033[m"
	fi

#	for hst in $(cat logs/$1.txt);
#	do
#		host $hst | grep "has address" |  sed 's/has address/54.38.191.102/' | column -t;
		# sed 's/has address/\tIP:/' | column -t -s ' ';
		# sed 's/has address/<< IP >>/' | column -t;
#	done
}

function init() {
	globais
	banner
  read -e -p "Ver:" -i "verificar" vip
	script $vip

	tput init
	reload "return" "menuInstall"
	pause

}



