#!/usr/bin/env bash
update(){
  echo "${BLUE}Atualizando o sistema...${NORMAL}"
  sudo yum update -y ;
  sudo yum upgrade -y;
  dnf install git -y;
  dnf install nano -y;
  dnf install wget curl -y;
  dnf install unrar -y;
  dnf install perl -y;
  sudo yum install openssh-clients -y;
  echo "${WHITE}Atualizado!"
  banner 5

  echo "${BLUE}Stopping and disabling NetworkManager and disabling SELINUX.${NORMAL}"
  systemctl stop NetworkManager ;
  systemctl disable NetworkManager ;
  NOW=$(date +"%m_%d_%Y-%H_%M_%S")
  cp /etc/selinux/config /etc/selinux/config.bckup.$NOW
  sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config ;
  log "NetworkManager stopped and disabled."
  echo "${WHITE}NetworkManager stopped and disabled."
  echo "${WHITE}Selinux Disabled."
  banner 5
  #extra
  iptables-save > ~/firewall.rules
  systemctl stop firewalld.service
  systemctl disable firewalld.service
  echo "${WHITE}disable firewalld.service."

  banner 5

  echo "${BLUE}Enabling / Updating initial quotas! A reboot in the end will be required.${NORMAL}"
  yes |  /scripts/initquotas ;
  echo "${WHITE}Server quotas are enabled!"
  banner 10
}
all(){


  #https://serverconfig.net/complete-guide-initial-server-setup-with-almalinux-8-including-phpmyadmin-mysql-ssl-apache-and-php-configuration/#:~:text=To%20install%20Apache%20on%20AlmaLinux%208%2C%20use%20the,sudo%20systemctl%20start%20httpd%20sudo%20systemctl%20enable%20httpd



sudo dnf install httpd httpd-tools
sudo systemctl start httpd
sudo systemctl enable httpd
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https

sudo firewall-cmd --reload
sudo dnf install mysql-server
sudo systemctl start mysqld
sudo systemctl enable mysqld

sudo nano /etc/ssh/sshd_config
#Disable root login: Set PermitRootLogin to no.
#Change the default SSH port (optional but recommended).
#Disable password authentication: Set PasswordAuthentication to no to enforce key-based authentication.
#Limit SSH access to specific users: Use the AllowUsers directive to specify the users allowed to SSH into the server.
#After making these changes, save the file and restart the SSH service:
sudo systemctl restart sshd

sudo mysql_secure_installation
sudo dnf install phpmyadmin
#sudo ln -s /usr/share/phpmyadmin /var/www/mywebsite/phpmyadmin
sudo dnf install certbot python3-certbot-apache
sudo certbot --apache


#sudo apt install apache2
#sudo systemctl status apache2
#sudo ufw app list
#sudo ufw allow 'Apache'
hostname -I | awk '{print $1}'

#sudo apt install php7.4-{mysql,common,curl,json,xsl,gd,xml,zip,xsl,soap,bcmath,mbstring,gettext,imagick}
#sudo apt install software-properties-common apt-transport-https -y
#sudo apt-get install -y php7.4-cli php7.4-json php7.4-common php7.4-mysql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath
  dnf install php-dev php-pecl -y;

#php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
#php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
#php composer-setup.php
#php -r "unlink('composer-setup.php');"
#php composer.phar --version

php -v

#cd /home && curl -o latest -L https://securedownloads.cpanel.net/latest && sh latest
service NetworkManager start
chkconfig NetworkManager on

reboot


#sudo chmod -R 777 /var/www/html
#sudo chmod -R 777 /var/www/html/*

#cd /var/www/html/
#git clone https://github.com/onixsat/instalar.git

}


function banner(){
	readonly version="1.0.0"
	readonly WHITE="$(tput setaf 7)"
	readonly CYAN="$(tput setaf 6)"
	readonly MAGENTA="$(tput setaf 5)"
	readonly YELLOW="$(tput setaf 3)"
	readonly GREEN="$(tput setaf 2)"
	readonly BLUE="$(tput setaf 4)"
	readonly RED="$(tput setaf 1)"
	readonly NORMAL="$(tput sgr0)"

	tput init
	ARG1=${1:-0}
    sleep "$ARG1"
	clear

	echo -n "${GREEN}                                                         "
    echo -e "${BLUE}                       Version ${version}${YELLOW} OnixSat"
    echo -n "${NORMAL}"
}




script(){

	if [ "$3" ]; then
		texto="${BLUE}
	 [+] ${WHITE}$3"
	else
	 	texto=" "
	fi


	echo -e "\033[32;94;2m
	_____________________________________________________________________________
	 [+] $1 ${RED}$2 ${texto} \033[32;94;2m
	-----------------------------------------------------------------------------
		\033[m"

data(){
  $1 > output.txt 2>&1
	while read p; do
		echo "         $p"
	done <output.txt
}
data "php -v"
data "ls"



#while read d1, d2;do
#    echo "         $d1,$d2"
#done < $1st_list,$2nd_list


	echo -e "\033[31;94;2m
	_____________________________________________________________________________
		\033[m"

}
rm output.txt
#apt install dnf -y &> /dev/null
clear
banner
#my_array=()
#my_array+=( "sudo yum update -y" )
#my_array+=( "sudo yum upgrade -y" )
#if [ $(dpkg-query -W -f='${Status}' dnf 2>/dev/null | grep -c "ok installed") -eq 0 ];
#then
 # apt install dnf;
#fi

pkgs='dnf'
install=false
for pkg in $pkgs; do
  status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>&1)"
  if [ ! $? = 0 ] || [ ! "$status" = installed ]; then
    install=true
    echo "1"
    #sleep 5
    break
  fi
done
if "$install"; then
  apt install $pkgs
  echo "2"
fi

echo "ok"

#dnf update -y > output.txt 2>&1
script "Atualizando o sistema" "output.txt" "texto"




