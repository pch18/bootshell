# 虚拟机/docker 初始化shell

## 使用方式
- 虚拟机中直接执行下述命令即可, 需要将脚本设置为自启动
- docker中将下属命令设置为
```shell
wget -O - sh.pch18.cn/v2ray-server/tls-ws | sh
# or
curl sh.pch18.cn/v2ray-server/tls-ws | sh
```

## 脚本格式

### setup.sh
如果目录下存在`setup.sh`则仅会在第一次自动运行, 运行成功后, 在`~/.psh.lock/`生成lock文件, 避免重复运行, 如果要重新setup, 可以删除lock文件, 或者重置环境
### entry.sh
setup 完成后, 自动运行`entry.sh`执行程序
### env
脚本中可直接使用环境变量
- `BASH_NAME` 当前目录名称
- `URL_REPO` 当前仓库的raw地址, 固定为: `https://raw.githubusercontent.com/pch18/bootshell/master/`
- `$URL_CURRENT` 当前目录地址, 固定为: `https://raw.githubusercontent.com/pch18/bootshell/master/${BASH_NAME}`

### 服务器脚本
```php
<?php
header('Content-type: text/plain');

$BASH_NAME = $_GET['s'];
$URL_REPO = "https://raw.fastgit.org/pch18/bootshell/main/";
$URL_CURRENT = $URL_REPO.$BASH_NAME."/";

$BASH_STR_SETUP = @file_get_contents($URL_CURRENT."setup.sh");
$BASH_STR_ENTRY = @file_get_contents($URL_CURRENT."entry.sh");

?>!# /bin/sh
BASH_NAME="<?=$BASH_NAME ?>"
URL_REPO="<?=$URL_REPO ?>"
URL_CURRENT="<?=$URL_CURRENT ?>"

copy(){
  if hash curl 2>/dev/null; then
    curl -o $2 "${$URL_CURRENT}$1"
  elif hash wget 2>/dev/null; then
    wget -O $2 "${$URL_CURRENT}$1"
  else
    echo "ERROR: 无法下载文件，请先安装 curl 或 wget ！!"
    exit 1
  fi
}

setup(){
<?=$BASH_STR_SETUP ?>
}

entry(){
<?=$BASH_STR_ENTRY ?>
}

<?php if(!empty($BASH_STR_SETUP)){ ?>
LOCK_DIR="~/.psh.lock"
LOCK_FILE="${LOCK_DIR}/${BASH_NAME}"
mkdir -p $LOCK_DIR
if[ ! -f $LOCK_FILE ];then
  echo "首次安装, 运行${BASH_NAME}/setup.sh"
  setup
  touch $LOCKFILE
fi
<?php }else{ ?>
echo "没有安装脚本，无需安装~"
<?php } ?>

<?php if(!empty($BASH_STR_ENTRY)){ ?>
echo "启动脚本, 运行${BASH_NAME}/entry.sh"
entry
<?php }else{ ?>
echo "没有启动脚本，退出~"
<?php } ?>

```