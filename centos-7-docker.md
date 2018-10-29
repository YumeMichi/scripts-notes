## CentOS 7 安装 Docker CE (社区版) 备忘

### 安装
```
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum install docker-ce

systemctl start docker
systemctl enable docker
```

### 常用命令
```
docker ps [-a]
docker inspect container_id
docker logs container_id
docker start/stop/rm container_id

docker pull image_name:tag
docker load < image_file
docker images
```

### 实例备忘
```
docker run -p 4200:4200 -p 4300:4300 --name crate -v /xcdata/docker/data:/data hub.c.163.com/library/crate:1.1.3
docker run -p 3306:3306 --name mysql -v /xcdata/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -d hub.c.163.com/library/mysql:5.6
docker run -p 80:80 --name web -v /xcdata/nginx/vhosts:/xcdata/server/nginx-1.4.4/conf/vhosts -v /xcdata/www:/xcdata/www -d mydt:20161219
```
