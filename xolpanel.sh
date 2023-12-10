#!/bin/bash
apt update -y
apt upgrade -y
domain="$(cat /etc/xray/domain)"
sldomain="$(cat /etc/xray/domain)"
#install
rm -rf xolpanel.sh
apt update && apt upgrade
apt install python3 python3-pip git
git clone https://github.com/myzhero/tunnel.git
unzip tunnel/xolpanel.zip
pip3 install -r xolpanel/requirements.txt
pip3 install pillow

clear
#isi data
echo ""
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your Id Telegram :" admin
echo -e BOT_TOKEN='"'$bottoken'"' >> /root/xolpanel/var.txt
echo -e ADMIN='"'$admin'"' >> /root/xolpanel/var.txt
echo -e DOMAIN='"'$domain'"' >> /root/xolpanel/var.txt
echo -e SLDOMAIN='"'$sldomain'"' >> /root/xolpanel/var.txt
clear
echo "Done"
echo "Your Data Bot"
echo -e "==============================="
echo "Bot Token     : $bottoken"
echo "Id Telegram   : $admin"
echo "Subdomain     : $domain"
echo "NSdomain      : $sldomain"
echo -e "==============================="
echo "Setting done Please wait 3s"
sleep sleep 3

cat > /etc/systemd/system/xolpanel.service << END
[Unit]
Description=Simple XolPanel - @XolPanel
After=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/python3 -m xolpanel
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl start xolpanel 
systemctl enable xolpanel
systemctl restart xolpanel

clear
echo -e "==============================================="
echo " Installations complete, type /menu on your bot"
echo -e "==============================================="
read -n 1 -s -r -p "Press any key to menu"
rm -rf xolpanel.sh
clear
menu
