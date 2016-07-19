#!/usr/bin/env bash

ruby $HOME/config/htpasswd.rb
erb $HOME/config/nginx.conf.erb > $HOME/config/nginx.conf

mkdir -p $HOME/logs/nginx
touch $HOME/logs/nginx/access.log $HOME/logs/nginx/error.log

(tail -f -n 0 $HOME/logs/nginx/*.log &)

ln -s $HOME/vendor/openresty/luajit/lib/libluajit-5.1.so.2.1.0 $HOME/lib/libluajit-5.1.so.2
exec $HOME/vendor/openresty/nginx/sbin/nginx -p $HOME -c $HOME/config/nginx.conf
