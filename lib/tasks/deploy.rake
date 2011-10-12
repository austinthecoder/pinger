task :deploy do
  system 'git push pinger-web master'
  system 'git push pinger-worker master'
  system 'git push pinger-scheduler master'

  system 'heroku ps --app pinger-web'
  system 'heroku ps --app pinger-worker'
  system 'heroku ps --app pinger-scheduler'
end