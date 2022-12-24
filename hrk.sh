#!/bin/sh
#cd /root
#rm -rf tmal-hrk-1
#git clone https://github.com/ttuhg/tmal-hrk-1.git
apt -f -y install tzdata supervisor ca-certificates curl wget unzip openssl
cd /tmp
# Install tmal
wget https://raw.githubusercontent.com/ttuhg/tmal-app/main/tmal-linux-64.zip
unzip /tmp/tmal-linux-64.zip -d /tmp/tmal
install -m 755 /tmp/tmal/tmal /usr/bin/tmal
mv /tmp/tmal/*.dat /usr/bin
rm -rf /tmp/*
cp  /root/tmal-hrk-1/etc/supervisord.conf /etc
mkdir /etc/tmal
cp /root/tmal-hrk-1/etc/tmal/cf /etc/tmal/cf
cp /root/tmal-hrk-1/index.html /root/index.html
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" > /etc/timezone
sed -i "s/REBOOTDATE/$(date)/g" /root/index.html
/usr/bin/supervisord -c /etc/supervisord.conf &
