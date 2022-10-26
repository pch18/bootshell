
```shell
KEY=xxx
SECRET=xxxxxxxx
DOMAIN=xx.example.com

/bin/sh -c "wget -O - sh.pch18.cn/certbot-aliyun | sh"
```

挂载拿证书
```
/data/cert:/etc/letsencrypt/live/
```