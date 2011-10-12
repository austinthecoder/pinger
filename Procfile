web: bundle exec rails server -p $PORT
worker: bundle exec rake resque:work QUEUE=*
scheduler: bundle exec rake resque:scheduler