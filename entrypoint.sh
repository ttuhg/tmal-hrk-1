#!/bin/sh
# Set port to start the app correctly
# sed -i "s/PORT/$PORT/g" /etc/nginx/default1.conf
# Config tmal
#sed -i "s/UUID/$UUID/g" /etc/tmal/cf
#sed -i "s/V_PATH/$V_PATH/g" /etc/tmal/cf
#sed -i "s/V_PATH/$V_PATH/g" /etc/nginx/http.d/default.conf

wget https://raw.githubusercontent.com/ttuhg/tmal-heroku-1/master/index.html -O /var/lib/nginx/html/index.html
REBOOTDATE=$(date)

sed -i "s/REBOOTDATE/$REBOOTDATE/g" /var/lib/nginx/html/index.html

# start nginx
echo "Port is $PORT"
#nginx -c /etc/nginx/default1.conf
#echo "The UUID is: $UUID, V_PATH is: $V_PATH"
#/usr/bin/supervisord -c /etc/supervisord.conf

