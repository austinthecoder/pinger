web: bundle exec rails server -p $PORT
worker: bundle exec rake environment resque:work QUEUE=*
scheduler: bundle exec rake resque:scheduler