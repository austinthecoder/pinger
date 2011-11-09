# Pinger

## What is it?

Pinger is a web application that let's you schedule HTTP requests and setup alerts based on the responses.

## Why would I use it?

Pinger is a good open source alternative for website monitoring. Set up an alert to notify via email when your site is down.

## Running on Heroku

* Create an app on Heroku on the cedar stack
* Setup Redis
  * Add the Redis To Go add-on
  * In the config directory, copy `redis_config.yml.example` to `redis_config.yml`
  * Fill in the values provided by the add-on
* Setup Resque
  * In the config directory, copy `resque_config.yml.example` to `resque_config.yml`
  * The `web_user` and `web_pass` is the login credentials for viewing your queues at the http://yourapp.herokuapp.com/resque

## Technologies

Pinger is built on, and makes use of:

* [Ruby on Rails](http://rubyonrails.org) - the web application framework
* [Resque](https://rubygems.org/gems/resque) - background job queueing, scheduling and processing
* [Cucumber](https://rubygems.org/gems/cucumber) - high level, acceptance-style testing
* [RSpec](https://rubygems.org/gems/rspec) - low level, unit-style testing

## Notes

Although Pinger is at a fairly stable version, it is very much a work-in-progress application. Contributions are very welcome.