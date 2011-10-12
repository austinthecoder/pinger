web: bundle exec rails server -p $PORT
worker: QUEUE=* bundle exec rake environment resque:work
scheduler: bundle exec rake resque:scheduler