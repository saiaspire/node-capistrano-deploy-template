Deploying Node applications using Capistrano
===============================

Capistrano is used for automated deployment of your applications, for more information please read [here](http://capistranorb.com/documentation/overview/what-is-capistrano/)

## Requirements
* Ruby >= 1.9 (JRuby and C-Ruby/YARV are supported)

## How to use?
Clone this repository, make sure you have Ruby installed on your machine and then execute the following to install Bundler

```
gem install bundler
```

Then to install Capistrano execute

```
bundle install
```
Bundler picks up the Capistrano version to install from the [Gemfile](https://github.com/saiaspire/node-capistrano-deploy-template/blob/master/Gemfile)

Once you have Capistrano installed, setup your development and production environments in [deploy.rb](https://github.com/saiaspire/node-capistrano-deploy-template/blob/master/config/deploy.rb)

Then execute
```
bundle exec cap [dev/production] deploy
```
from your local machine to deploy to the respective environments.

You may require the relevant SSH keys to be able to deploy.
