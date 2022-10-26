
cat > /tmp/credentials.ini <<EOF
certbot_dns_aliyun:dns_aliyun_access_key = ${KEY}
certbot_dns_aliyun:dns_aliyun_access_key_secret = ${SECRET}
EOF

chmod 600 /tmp/credentials.ini

cat > /tmp/cert <<EOF
#! /bin/sh
certbot certonly \
-a certbot-dns-aliyun:dns-aliyun \
--certbot-dns-aliyun:dns-aliyun-credentials /tmp/credentials.ini \
--agree-tos --no-eff-email --keep \
-m ${DOMAIN} \
-d home.pch18.cn 
EOF
chmod 777 /tmp/cert

echo "0 0,12 * * * root sleep 567 && /tmp/cert" | tee -a /var/spool/cron/crontabs/root > /dev/null

/tmp/cert
crond -f