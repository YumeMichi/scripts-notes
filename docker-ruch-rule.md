## 场景
docker 内的几个服务需要访问到宿主机的某个端口（服务）。

## 命令
首先先创建一个 ipset，将需要访问宿主机服务的几个容器的 IP 放进去
```
firewall-cmd --permanent --zone=public --new-ipset=kafka-apps --type=hash:ip
firewall-cmd --permanent --zone=public --ipset=kafka-apps --add-entry=172.17.0.2
firewall-cmd --permanent --zone=public --ipset=kafka-apps --add-entry=172.17.0.3
```

开放 docker 外部网络访问
```
firewall-cmd --permanent --zone=public --add-masquerade
```

添加对应的 ipset 访问宿主机服务
```
firewall-cmd --permanent --add-rich-rule="rule source ipset=kafka-apps port port=9092 protocol=tcp accept"
```

## 参考资料
[使用 firewalld 构建 Linux 动态防火墙](https://www.ibm.com/developerworks/cn/linux/1507_caojh/index.html)
