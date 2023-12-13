#!/bin/bash
#color
grenbo="\e[92;1m"
NC='\e[0m'
u="\033[1;36m"
y="\033[1;93m"
g="\033[1;92m"
r="\033[1;91m"

REPO="https://raw.githubusercontent.com/FdlyMots/bot_tele/hunters/"
NS=$( cat /etc/xray/dns )
PUB=$( cat /etc/slowdns/server.pub )
domain=$(cat /etc/xray/domain)
#install
apt update && apt upgrade
apt install python3 python3-pip git
cd /usr/bin
wget -q ${REPO}bot.zip
unzip bot.zip
mv bot/* /usr/bin
chmod +x /usr/bin/*
rm -rf bot.zip
clear
wget -q ${REPO}kyt.zip
unzip kyt.zip
pip3 install -r kyt/requirements.txt

clear
echo ""
echo -e "$u ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " \e[1;97;101m             ADD BOT PANEL              \e[0m"
echo -e "$u ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${grenbo}Tutorial Creat Bot and ID Telegram${NC}"
echo -e "${grenbo}[*] Creat Bot and Token Bot : @BotFather${NC}"
echo -e "${grenbo}[*] Info Id Telegram : @MissRose_bot , perintah /info${NC}"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e ""
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your Id Telegram : " admin
echo -e BOT_TOKEN='"'$bottoken'"' >> /usr/bin/kyt/var.txt
echo -e ADMIN='"'$admin'"' >> /usr/bin/kyt/var.txt
echo -e DOMAIN='"'$domain'"' >> /usr/bin/kyt/var.txt
echo -e PUB='"'$PUB'"' >> /usr/bin/kyt/var.txt
echo -e HOST='"'$NS'"' >> /usr/bin/kyt/var.txt
clear

rm -fr /etc/systemd/system/fvbot.service

cat > /etc/systemd/system/fvbot.service << END
[Unit]
Description=Simple fvbot - @fv_stores
After=network.target

[Service]
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/python3 -m kyt
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl start fvbot 
systemctl enable fvbot
systemctl restart fvbot
cd /root
rm -rf bot.sh

# // STATUS SERVICE BOT
bot_service=$(systemctl status fvbot | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $bot_service == "running" ]]; then 
   sts_bot="${g}Online${NC}"
else
   sts_bot="${r}Offline${NC}"
fi

clear
neofetch
echo -e "  ${y} Your Data BOT Info"
echo -e "  ${u}┌───────────────────────────────────┐${NC}"
echo -e "  ${u}│$r Status BOT ${y}=$NC $sts_bot "
echo -e "  ${u}│$r Token BOT  ${y}=$NC $bottoken "
echo -e "  ${u}│$r Admin ID   ${y}=$NC $admin "
echo -e "  ${u}│$r Domain VPS ${y}=$NC $domain "
echo -e "  ${u}└───────────────────────────────────┘${NC}"
echo -e ""
read -p "  Press [ Enter ] to back on menu"
menu
