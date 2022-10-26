dl caddy.conf /etc/caddy/caddy.conf
dl v2ray.json /etc/v2ray/v2ray.json

# 启动caddy
caddy run --config /etc/caddy/caddy.conf --adapter caddyfile >&1 &

# 启动v2ray
sed -i "s/\$UUID/${UUID}/" /etc/v2ray/v2ray.json
v2ray run -c /etc/v2ray/v2ray.json