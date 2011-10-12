web: bundle exec rails server -p $PORT
worker: bundle exec rake resque:work QUEUE=* --trace
scheduler: bundle exec rake resque:scheduler