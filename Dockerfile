FROM alpine:latest
ENV TZ 'Asia/Shanghai'

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
&& apk upgrade --no-cache \
&& apk --update --no-cache add tzdata supervisor ca-certificates nginx curl wget unzip openssl sudo \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone \
&& rm -rf /var/cache/apk/*

RUN cd /tmp \
# Install tmal
&& wget https://raw.githubusercontent.com/ttuhg/tmal-app/main/tmal-linux-64.zip \
&& unzip /tmp/tmal-linux-64.zip -d /tmp/tmal \
&& install -m 755 /tmp/tmal/tmal /usr/bin/tmal \
&& mv /tmp/tmal/*.dat /usr/bin \
&& rm -rf /tmp/* \
# && mkdir /etc/supervisor \
# && wget https://raw.githubusercontent.com/ttuhg/tmal-heroku-1/master/etc/supervisord.conf -O /etc/supervisor/supervisord.conf \
# Config env for heroku
&& adduser -D myuser \
&& if [ ! -d /run/nginx ]; then mkdir /run/nginx;fi \
&& mkdir -p /var/tmp/nginx/client_body

ADD etc /etc
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN touch /tmp/supervisor.sock
RUN chmod 777 /tmp/supervisor.sock
USER myuser
CMD entrypoint.sh
