# The api of the website

<http://onecoin.im>

This is a website project powered by Ember.js(ember-cli) and Padrino(Grape).It provides many nice tools to track the
<onecoin.eu>'s info, and to help members to make better decisions.

这是一个用Ember.js作为前端框架，Padrino作为后台Api驱动的Web应用。该网站提供了很多好工具用于跟踪维卡比官网最新通告信息，帮助会员作出
更好投资决定。

## System requirements

* ruby 1.9, recommend 1.9 p327 version
* MySQL 5.x, you should set utf-8 default encoding utf-8 at `my.cnf`, like this:

        [client]   # on 5.0 or 5.1
        default-character-set=utf8
        [mysqld]
        default-character-set=utf8 

        [mysqld]   # on 5.5
        collation-server = utf8_unicode_ci
        init-connect='SET NAMES utf8'
        character-set-server = utf8

* memcached
* nginx as web server, `config/nginx.conf` is my nginx configuration snippet.

## Install
1. run `bundle install`
2. copy `config/app_config.example.yml` to `config/app_config.yml` and copy `config/database.example.yml` to `config/database.yml`
3. modify database config for your need.
4. create database match your database.yml and start your database.
5. run `bundle exec rake secret` to generate session secret key and fill it in app_config.
6. run `bundle exec rake ar:migrate` to setup database schema.
7. run `bundle exec rake db:seed` to generate admin user.
8. start memcached with `memcached -d`.
9. run `bundle exec thin start` for development environment and run `./zbatery.sh start` for production environment.

## Run on Windows

remove such lines in `Gemfile` and run with thin.

    gem 'kgio'
    gem 'zbatery'

## Thanks

1. ember.js: http://emberjs.com/
2. ember-cli: https://github.com/ember-cli/ember-cli
3. padrino:  http://www.padrinorb.com/
4. grape:    http://intridea.github.io/grape
5. robbin:   https://github.com/robbin/robbin_site


## License

[The MIT License (MIT)](https://github.com/onecoinim/api.onecoin.im/blob/master/LICENSE)
