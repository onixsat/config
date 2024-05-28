#!/bin/bash
function globais(){

	readonly sshport="222"
	readonly version="1.0.0"
	readonly WHITE="$(tput setaf 7)"
	readonly CYAN="$(tput setaf 6)"
	readonly MAGENTA="$(tput setaf 5)"
	readonly YELLOW="$(tput setaf 3)"
	readonly GREEN="$(tput setaf 2)"
	readonly BLUE="$(tput setaf 4)"
	readonly RED="$(tput setaf 1)"
	readonly NORMAL="$(tput sgr0)"

	readonly server_name='$(hostname)'
	readonly green='\e[32m'
	readonly blue='\e[34m'
	readonly clear='\e[0m'

	ColorGreen(){
		echo -ne $green$1$clear
	}
	ColorBlue(){
		echo -ne $blue$1$clear
	}



	if [ ! -d ajuda ]
	then
		mkdir -p ajuda
	fi

	if [[ ! -e "ajuda/ajuda1.html" ]];
	then
		truncate -s 0 ajuda/ajuda1.html
		touch ajuda/ajuda1.html
		cat > 'ajuda/ajuda1.html' < 'includes/ajuda1.html'
	fi

	if [[ ! -e ajuda/ajuda2.html ]]; then
		truncate -s 0 ajuda/ajuda1.html
		touch ajuda/ajuda2.html
		cat > ajuda/ajuda2.html <<- "EOF"
		ajuda 2
		EOF
	fi




}
function banner(){

	ARG1=${1:-0}
    sleep "$ARG1"
	clear
    echo -n "${GREEN}                                                         "
    echo -e "${BLUE}                       Version ${version}${YELLOW} OnixSat"
    echo -n "${NORMAL}"

}
all(){

#sudo su -
#cd /home/
#sudo apt install apache2
#sudo systemctl status apache2
#sudo ufw app list
#sudo ufw allow 'Apache'
hostname -I | awk '{print $1}'

#sudo apt install php7.4-{mysql,common,curl,json,xsl,gd,xml,zip,xsl,soap,bcmath,mbstring,gettext,imagick}
#sudo apt install software-properties-common apt-transport-https -y
#sudo apt-get install -y php7.4-cli php7.4-json php7.4-common php7.4-mysql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath


#php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
#php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
#php composer-setup.php
#php -r "unlink('composer-setup.php');"
#php composer.phar --version

php -v

#sudo chmod -R 777 /var/www/html
#sudo chmod -R 777 /var/www/html/*

#cd /var/www/html/
#git clone https://github.com/onixsat/instalar.git
#cd instalar/

#mkdir html2text
#unrar html2text.rar html2text
#unrar x html2text.rar html2text
#unrar x html2text.rar
#sudo unrar x html2text.rar
#cd ..
#bash btk.sh
}
script(){
  wget https://raw.githubusercontent.com/TedLeRoy/first-ten-seconds-redhat-ubuntu/master/first-ten.sh
  chmod -R 777 first-ten.sh
  #./first-ten.sh
  source first-ten.sh
}
iniciar() {
  echo "${BLUE}Iniciando o sistema...${NORMAL}"
  sudo yum update -y;
  sudo yum upgrade -y;
  dnf install git -y
  dnf install nano -y;
  dnf install wget curl -y;
  dnf install php-dev php-pecl -y;
  dnf install unrar -y;
  sudo yum install openssh-clients -y;
  echo "${WHITE}Atualizado!"

banner 2
  echo "${BLUE}Stopping and disabling NetworkManager and disabling SELINUX.${NORMAL}"
  systemctl stop NetworkManager ;
  systemctl disable NetworkManager ;
  NOW=$(date +"%m_%d_%Y-%H_%M_%S")
  cp /etc/selinux/config /etc/selinux/config.bckup.$NOW
  sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config ;
  log "NetworkManager stopped and disabled."
  echo "${WHITE}NetworkManager stopped and disabled."
  echo "${WHITE}Selinux Disabled."
  banner 2

  echo "${BLUE}Enabling / Updating initial quotas! A reboot in the end will be required.${NORMAL}"
  yes |  /scripts/initquotas ;
  echo "${WHITE}Server quotas are enabled!"
  banner 5
}





	globais
	banner
	iniciar
	tput init
	#pause




