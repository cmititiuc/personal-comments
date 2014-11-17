*Really simple* weekly schedule and meal plan app.

ophect.me

<h4>Deploy Steps (Digital Ocean)</h4>

generate ssh key

enter ssh key into digitalocean

create ubuntu 14.10 droplet

ssh in as root

sudo adduser deployer

sudo adduser deployer sudo

su deployer

ssh-copy-id deployer@ophect.me

sudo apt-get update

sudo apt-get install curl git-core build-essential zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libcurl4-openssl-dev libxml2-dev libxslt1-dev python-software-properties 

\curl -sSL https://get.rvm.io | bash -s stable

gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable

source /home/deployer/.rvm/scripts/rvm

gpg --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7 

gpg --armor --export 561F9B9CAC40B2F7 | sudo apt-key add - 

sudo apt-get install apt-transport-https  

sudo sh -c "echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main' >> /etc/apt/sources.list.d/passenger.list"

sudo chown root: /etc/apt/sources.list.d/passenger.list  
sudo chmod 600 /etc/apt/sources.list.d/passenger.list  
sudo apt-get update  

sudo apt-get install nginx-full passenger 

sudo service nginx start  

rvm install 2.1.5

edit nginx config:
passenger_root /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini;
passenger_ruby /home/deployer/.rvm/wrappers/ruby-2.1.5/ruby;

mina setup --verbose

edit shared/database.yml and shared/secrets.yml

sudo apt-get install nodejs

mina deploy

rvm use 2.1.5 (not sure if I had to do this)

changed database.yml production path to outside source tree so it doesn't get replaced on deploy

<h4>/etc/nginx/nginx.conf</h4>
````
user www-data;
worker_processes 4;
pid /run/nginx.pid;

events {
  worker_connections 768;
  # multi_accept on;
}

http {

  ##
  # Basic Settings
  ##

  sendfile on;
  tcp_nopush on;
  tcp_nodelay on;
  keepalive_timeout 65;
  types_hash_max_size 2048;
  # server_tokens off;

  # server_names_hash_bucket_size 64;
  # server_name_in_redirect off;

  include /etc/nginx/mime.types;
  default_type application/octet-stream;

  ##
  # Logging Settings
  ##

  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log;

  ##
  # Gzip Settings
  ##

  gzip on;
  gzip_disable "msie6";

  # gzip_vary on;
  # gzip_proxied any;
  # gzip_comp_level 6;
  # gzip_buffers 16 8k;
  # gzip_http_version 1.1;
  # gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;

  ##
  # nginx-naxsi config
  ##
  # Uncomment it if you installed nginx-naxsi
  ##

  # include /etc/nginx/naxsi_core.rules;

  ##
  # Phusion Passenger config
  ##
  # Uncomment it if you installed passenger or passenger-enterprise
  ##
  
  passenger_root /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini;
  # passenger_ruby /usr/bin/ruby;
  passenger_ruby /home/deployer/.rvm/wrappers/ruby-2.1.5/ruby;

  ##
  # Virtual Host Configs
  ##

  include /etc/nginx/conf.d/*.conf;
  include /etc/nginx/sites-enabled/*;
}


# mail {
# # See sample authentication script at:
# # http://wiki.nginx.org/ImapAuthenticateWithApachePhpScript
# 
# # auth_http localhost/auth.php;
# # pop3_capabilities "TOP" "USER";
# # imap_capabilities "IMAP4rev1" "UIDPLUS";
# 
# server {
#   listen     localhost:110;
#   protocol   pop3;
#   proxy      on;
# }
# 
# server {
#   listen     localhost:143;
#   protocol   imap;
#   proxy      on;
# }
# }
````

<h4>/etc/nginx/sites-enabled/default</h4>
````
# You may add here your
# server {
# ...
# }
# statements for each of your virtual hosts to this file

##
# You should look at the following URL's in order to grasp a solid understanding
# of Nginx configuration files in order to fully unleash the power of Nginx.
# http://wiki.nginx.org/Pitfalls
# http://wiki.nginx.org/QuickStart
# http://wiki.nginx.org/Configuration
#
# Generally, you will want to move this file somewhere, and start with a clean
# file but keep this around for reference. Or just disable in sites-enabled.
#
# Please see /usr/share/doc/nginx-doc/examples/ for more detailed examples.
##

server {
  # listen 80 default_server;
  # listen [::]:80 default_server ipv6only=on;
  listen 80;
  passenger_enabled on;

  # root /usr/share/nginx/html;
  root /home/deployer/fuzzy-sched/current/public;
  rails_env production;
  # index index.html index.htm;

  # Make site accessible from http://localhost/
  server_name ophect.me www.ophect.me;

  # location / {
    # First attempt to serve request as file, then
    # as directory, then fall back to displaying a 404.
    # try_files $uri $uri/ =404;
    # Uncomment to enable naxsi on this location
    # include /etc/nginx/naxsi.rules
  # }

  # Only for nginx-naxsi used with nginx-naxsi-ui : process denied requests
  # location /RequestDenied {
  # proxy_pass http://127.0.0.1:8080;    
  # }

  # error_page 404 /404.html;

  # redirect server error pages to the static page /50x.html
  #
  # error_page 500 502 503 504 /50x.html;
  # location = /50x.html {
  # root /usr/share/nginx/html;
  # }

  # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
  #
  # location ~ \.php$ {
  # fastcgi_split_path_info ^(.+\.php)(/.+)$;
  # # NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini
  #
  # # With php5-cgi alone:
  # fastcgi_pass 127.0.0.1:9000;
  # # With php5-fpm:
  # fastcgi_pass unix:/var/run/php5-fpm.sock;
  # fastcgi_index index.php;
  # include fastcgi_params;
  # }

  # deny access to .htaccess files, if Apache's document root
  # concurs with nginx's one
  #
  # location ~ /\.ht {
  # deny all;
  # }
}


# another virtual host using mix of IP-, name-, and port-based configuration
#
# server {
# listen 8000;
# listen somename:8080;
# server_name somename alias another.alias;
# root html;
# index index.html index.htm;
#
# location / {
#   try_files $uri $uri/ =404;
# }
# }


# HTTPS server
#
# server {
# listen 443;
# server_name localhost;
#
# root html;
# index index.html index.htm;
#
# ssl on;
# ssl_certificate cert.pem;
# ssl_certificate_key cert.key;
#
# ssl_session_timeout 5m;
#
# ssl_protocols SSLv3 TLSv1 TLSv1.1 TLSv1.2;
# ssl_ciphers "HIGH:!aNULL:!MD5 or HIGH:!aNULL:!MD5:!3DES";
# ssl_prefer_server_ciphers on;
#
# location / {
#   try_files $uri $uri/ =404;
# }
# }
````