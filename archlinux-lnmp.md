# ArchLinux LNMP (Not for production environment)

## MySQL

Install MySQL via pacman
```
sudo pacman -S mariadb
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
```

Start MySQL service
```
sudo systemctl start mysqld
```


## PHP
Install PHP 5.6 via source code

### Readline Version 6
PHP 5.6 doesn't support readline version 7, I need compile readline 6 to make it work.
```
wget ftp://ftp.gnu.org/gnu/readline/readline-6.3.tar.gz
tar xf readline-6.3.tar.gz
cd readline-6.3
./configure --prefix=/usr/local/readline6
make -j8
sudo make install
sudo ln -s /usr/local/readline6/lib/libreadline.so.6.3 /usr/lib/libreadline.so.6
```

### PHP 5.6
```
wget -q http://cn2.php.net/distributions/php-5.6.36.tar.gz
tar xf php-5.6.36.tar.gz
cd php-5.6.36
./configure --prefix=/usr/local/php/5.6 --with-mysql --with-mysqli --with-pdo-mysql --with-readline --enable-mbstring --enable-fpm --with-fpm-user=ikke --with-fpm-group=users --with-fpm-systemd --with-pdo-pgsql --with-curl
make -j8
sudo make install
sudo cp php.ini-production /usr/local/php/5.6/lib/php.ini
```

### Redis for PHP
```
cd ext
git clone https://github.com/phpredis/phpredis.git
cd phpredis
/usr/local/php/5.6/bin/phpize
./configure --with-php-config=/usr/local/php/5.6/bin/php-config
make -j8
sudo make install

echo "extension = redis.so" >> /usr/local/php/5.6/lib/php.ini
```

Replace `/usr/lib/systemd/system/php-fpm.service` with:
```
# It's not recommended to modify this file in-place, because it
# will be overwritten during upgrades.  If you want to customize,
# the best way is to use the "systemctl edit" command.

[Unit]
Description=The PHP FastCGI Process Manager
After=network.target

[Service]
Type=notify
PIDFile=/run/php-fpm/php-fpm.pid
ExecStart=/usr/local/php/5.6/sbin/php-fpm --nodaemonize --fpm-config /usr/local/php/5.6/etc/php-fpm.conf
ExecReload=/bin/kill -USR2 $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

Start PHP-FPM service
```
sudo systemctl daemon-reload
sudo systemctl start php-fpm
```


## Nginx
Install Nginx via source code
```
wget http://nginx.org/download/nginx-1.14.0.tar.gz
tar xvf nginx-1.14.0.tar.gz
cd nginx-1.14.0
./configure --prefix=/usr/local/nginx --with-http_v2_module --with-http_ssl_module --with-http_gzip_static_module --with-cc-opt=-Wno-deprecated-declarations
make -j8
sudo make install
```

Replace `/usr/local/nginx/conf/nginx.conf` with:
```
user  ikke users;
worker_processes  4;
#Specifies the value for maximum file descriptors that can be opened by this process.
worker_rlimit_nofile 65535;
events {
	use epoll;
	worker_connections 65535;
}
http {
    include       mime.types;
    default_type  application/octet-stream;
    #charset  gb2312;
    server_names_hash_bucket_size 128;
    client_header_buffer_size 32k;
    large_client_header_buffers 4 32k;
    client_max_body_size 8m;
    sendfile on;
    tcp_nopush     on;
    keepalive_timeout 60;
    tcp_nodelay on;
    fastcgi_connect_timeout 300;
    fastcgi_send_timeout 300;
    fastcgi_read_timeout 300;
    fastcgi_buffer_size 64k;
    fastcgi_buffers 4 64k;
    fastcgi_busy_buffers_size 128k;
    fastcgi_temp_file_write_size 128k;
    gzip on;
    gzip_min_length  1k;
    gzip_buffers     4 16k;
    gzip_http_version 1.0;
    gzip_comp_level 2;
    gzip_types       text/plain application/x-javascript text/css application/xml;
    gzip_vary on;
    #limit_zone  crawler  $binary_remote_addr  10m;
    log_format '$remote_addr - $remote_user [$time_local] "$request" '
		'$status $body_bytes_sent "$http_referer" '
		'"$http_user_agent" "$http_x_forwarded_for"';
    include vhosts/*.conf;
}
```

Configure virtual hosts
```
sudo mkdir /usr/local/nginx/conf/vhosts
touch /usr/local/nginx/conf/vhosts/web.conf
```

```
server {
    server_name localhost;
    listen 80;
    root /var/www/html;
    index  index.php index.html index.htm;

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}
```

Replace `/usr/lib/systemd/system/nginx.service` with:
```
[Unit]
Description=A high performance web server and a reverse proxy server
After=network.target network-online.target nss-lookup.target

[Service]
Type=forking
PIDFile=/run/nginx.pid
PrivateDevices=yes
SyslogLevel=err

ExecStart=/usr/local/nginx/sbin/nginx -g 'pid /run/nginx.pid; error_log stderr;'
ExecReload=/usr/local/nginx/sbin/nginx -s reload
KillMode=mixed

[Install]
WantedBy=multi-user.target
```

Start Nginx service
```
sudo systemctl daemon-reload
sudo systemctl start nginx
```
