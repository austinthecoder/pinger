# Pinger

A web application that let's you schedule HTTP requests and setup alerts based on the responses.

## Why would I use it?

Pinger is a good open source alternative for website monitoring. Set up an alert to notify via email when your site is down.

## Running on Heroku

These instructions assume you have a good understanding of Heroku. If you're having troubles or find a bug with any of these steps, please [add a GitHub issue](https://github.com/soccer022483/pinger/issues).

* Create an app on Heroku on the cedar stack
* Setup Redis
  * Add the Redis To Go add-on
  * In the config directory, copy `redis_config.yml.example` to `redis_config.yml`
  * Fill in the values provided by the add-on
* Setup Resque
  * In the config directory, copy `resque_config.yml.example` to `resque_config.yml`
  * The `web_user` and `web_pass` are the login credentials for viewing your queues at the yourapp.herokuapp.com/resque
* Deploy to Heroku

Running this application requires 3 running processes: a web server, worker, and scheduler. This can get quite expensive on Heroku, as they charge $0.05/hour per process. To run this app for free, try this:

* Create 3 Heroku apps, one for each process. For example: pinger-web, pinger-worker and pinger-scheduler
* Only install the Redis To Go add-on on the worker app
* Make sure all 3 apps have the same DATABASE_URL environment variable
* Make sure the web app runs the web process only, the worker app runs the worker process only and the scheduler app runs the scheduler process only

## Technologies

Pinger is built on, and makes use of:

* [Ruby on Rails](http://rubyonrails.org) - the web application framework
* [Resque](https://rubygems.org/gems/resque) - background job queueing, scheduling and processing
* [Cucumber](https://rubygems.org/gems/cucumber) - high level, acceptance-style testing
* [RSpec](https://rubygems.org/gems/rspec) - low level, unit-style testing

## Notes

Although Pinger is pretty stable, it's very much a work-in-progress. Contributions are welcome.