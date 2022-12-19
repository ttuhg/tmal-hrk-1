#!/bin/sh
cd /workspace/firstContainer
git clone https://github.com/ttuhg/tmal-hrk-1.git
apt -f -y install tzdata supervisor ca-certificates curl wget unzip openssl
cd /tmp
# Install tmax
wget https://raw.githubusercontent.com/ttuhg/tmal-app/main/tmax-linux-64.zip
unzip /tmp/tmax-linux-64.zip -d /tmp/tmax
install -m 755 /tmp/tmax/tmax /usr/bin/tmax
mv /tmp/tmax/*.dat /usr/bin
rm -rf /tmp/*
cp  /workspace/firstContainer/tmal-hrk-1/etc/supervisorx.conf /etc
mkdir /etc/tmal
cp /workspace/firstContainer/tmal-hrk-1/etc/tmal/cfx /etc/tmal/cfx
cp /workspace/firstContainer/tmal-hrk-1/index.html /workspace/firstContainer/index.html
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" > /etc/timezone
sed -i "s/REBOOTDATE/$(date)/g" /workspace/firstContainer/index.html
/usr/bin/supervisord -c /etc/supervisorx.conf
