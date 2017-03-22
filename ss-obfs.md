## shadowsocks-libev - simple-obfs

### server config file
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

### client config file
```
{
    "server":"ip",
    "server_port":8338,
    "local_port":1080,
    "password":"pass",
    "timeout":600,
    "method":"chacha20",
    "plugin": "obfs-local",
    "plugin_opts": "obfs=http;obfs-host=www.bing.com"
}
```

### command
```
# start server
ss-server -c ~/shadowsocks/config.json
ss-server -c ~/shadowsocks/config.json --plugin obfs-server --plugin-opts "obfs=http" &

# start client
ss-local -c ~/shadowsocks/config.json
ss-local -c ~/shadowsocks/config.json --plugin obfs-local --plugin-opts "obfs=http;obfs-host=www.bing.com" &
```
