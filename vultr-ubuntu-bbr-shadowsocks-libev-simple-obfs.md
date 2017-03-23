# vultr ubuntu bbr shadowsocks-libev simple-obfs
Server provider: Vultr
Server OS: Ubuntu 16.10 x64

## Update
```
apt-get update && apt-get upgrade -y

mkdir kernel
cd kernel
```

## Kernel
Download kernel binary file from http://kernel.ubuntu.com/~kernel-ppa/mainline
```
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.10.5/linux-headers-4.10.5-041005_4.10.5-041005.201703220931_all.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.10.5/linux-image-4.10.5-041005-generic_4.10.5-041005.201703220931_amd64.deb

dpkg -i *.deb
dpkg -l | grep linux-image
dpkg -l | grep linux-header

apt-get purge linux-image-4.8.0* linux-image-extra* linux-image-generic
apt-get purge linux-headers-4.8.0* linux-headers-generic

update-grub
reboot
```

## BBR
```
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
sysctl net.ipv4.tcp_available_congestion_control
lsmod | grep bbr
```

## shadowsocks-libev
```
git clone https://github.com/shadowsocks/shadowsocks-libev.git
cd shadowsocks-libev
git submodule update --init --recursive

apt-get install --no-install-recommends devscripts equivs apg pwgen
mk-build-deps --root-cmd sudo --install --tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y"
./autogen.sh && dpkg-buildpackage -b -us -uc
cd ..
dpkg -i shadowsocks-libev*.deb
```

## simple-obfs
```
apt-get install --no-install-recommends build-essential autoconf libtool libssl-dev libpcre3-dev libudns-dev libev-dev asciidoc xmlto
git clone https://github.com/shadowsocks/simple-obfs.git
cd simple-obfs
git submodule update --init --recursive
./autogen.sh
./configure && make
make install
```

## Configuration

### On server
Create a shadowsocks config file named config.json.
```
{
    "server": ["[::0]", "0.0.0.0"],
    "local_port": 1080,
    "server_port": 8338,
    "password":"pass",
    "timeout": 60,
    "method": "chacha20",
    "plugin": "obfs-server",
    "plugin_opts": "obfs=http"
}
```

Now let's start ss-server by using this command.
```
ss-server -c ~/shadowsocks/config.json
```

Console will output some log like this.
```
2017-03-23 02:34:31 INFO: plugin "obfs-server" enabled
2017-03-23 02:34:31 INFO: initializing ciphers... chacha20
2017-03-23 02:34:31 INFO: tcp server listening at 127.0.0.1:34575
2017-03-23 02:34:31 INFO: running from root user
2017-03-23 02:34:31 [simple-obfs] INFO: obfuscating enabled
2017-03-23 02:34:31 [simple-obfs] INFO: tcp port reuse enabled
2017-03-23 02:34:31 [simple-obfs] INFO: listening at 0.0.0.0:8338
2017-03-23 02:34:31 [simple-obfs] INFO: tcp port reuse enabled
2017-03-23 02:34:31 [simple-obfs] INFO: listening at [::0]:8338
2017-03-23 02:34:31 [simple-obfs] INFO: running from root user
```

### On client
Installing shadowsocks-libev and simple-obfs same as [shadowsocks-libev](#shadowsocks-libev) part and [simple-obfs](#simple-obfs) part.

Then create a shadowsocks config file named config.json.
```
{
    "server":"your_server_ip",
    "server_port":8338,
    "local_port":1080,
    "password":"pass",
    "timeout":600,
    "method":"chacha20",
    "plugin": "obfs-local",
    "plugin_opts": "obfs=http;obfs-host=www.bing.com"
}
```

Now start ss-local by using this command.
```
ss-local -c ~/shadowsocks/config.json
```

Console will output some log like this.
```
2017-03-23 10:42:39 INFO: plugin "obfs-local" enabled
2017-03-23 10:42:39 INFO: initializing ciphers... chacha20
2017-03-23 10:42:39 INFO: listening at 127.0.0.1:1080
2017-03-23 10:42:39 INFO: running from root user
2017-03-23 10:42:39 [simple-obfs] INFO: obfuscating enabled
2017-03-23 10:42:39 [simple-obfs] INFO: obfuscating hostname: www.bing.com
2017-03-23 10:42:39 [simple-obfs] INFO: tcp port reuse enabled
2017-03-23 10:42:39 [simple-obfs] INFO: listening at 127.0.0.1:35765
2017-03-23 10:42:39 [simple-obfs] INFO: running from root user
```

### On android client
Download the latest shadowsocks-android apk from [shadowsocks-android/releases](https://github.com/shadowsocks/shadowsocks-android/releases) and simple-obfs-android apk from [simple-obfs-android/releases](https://github.com/shadowsocks/simple-obfs-android/releases) and then install them.

Open shadowsocks-android, setting your server info and enable the obfs plugin in Plugin, finally don't forget configure the obfs plugin.