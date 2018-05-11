## Ubuntu Server 安装升级备忘

## 场景
今天把原本用于做家用服务器的笔记本上的 Ubuntu Server 重装了一遍，原本是 16.04 的版本，因为之前手贱装了个 GNOME 环境，卸载又有很多其他应用残留，干脆直接重装算了。

然而当我下完 Ubuntu Server 18.04 的镜像，做好启动盘后，安装进行到网络设置，竟然无法跳过，甚至连无线网卡都没识别，这让我咋装？我这里只有无线网络，连根网线都没有，于是乎只能下载 16.04 的版本全新安装一遍后再在线升级到 18.04 了。

升级命令：
```
do-release-upgrade -d
```

放心升级，就核心服务似乎并没有升挂，要是加上桌面环境等其他东西还真不好说。


## 无线网络
有别于桌面环境，服务器版安装完，只有本地环回网卡是默认启用的，有线网卡和无线网卡都没有启用。

那就先让网络通起来，首先查看一下本地都有哪些网卡，使用 `iwconfig`，我这里分别有以下几个网卡
```
wlp1s0
enp2s0
lo
```
其中 `wlp1s0` 就是无线网卡，`enp2s0` 是有线网卡，`lo` 是本地环回网卡。

接下来打开 `/etc/network/interfaces`，可以看到只有 `lo` 的配置，加入无线网卡的配置
```
auto wlp1s0
iface wlp1s0 inet dhcp
```
表示自动启动无线网卡，通过 DHCP 方式获取 IP。

再来是连接无线网络，一般来说家里的无线都是固定的 SSID 和密码，那么就可以直接使用配置文件，然后通过 `wpa-conf` 读取。
生成配置文件
```
wpa_passphrase SSID PASS > /etc/wpa_supplicant/wifi.conf
```
`wifi.conf` 会保存 SSID 名称，注释的明文和加密的密文

继续编辑 `/etc/network/interfaces`，在前面无线网卡配置后面加载 `wifi.conf`
```
auto wlp1s0
iface wlp1s0 inet dhcp
wpa-conf /etc/wpa_supplicant/wifi.conf
```

重启系统即可

## 电源管理
因为是笔记本，所以我肯定是不希望合上盖子后笔记本会休眠的。

编辑 `/etc/systemd/logind.conf` 文件，找到 `HandleLidSwitch`，取消其注释，并将值改成 `ignore`，然后重启电脑或者 `systemd-logind` 服务即可。
