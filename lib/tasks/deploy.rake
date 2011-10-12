task :deploy do
  system 'git push pinger-web master'
  system 'git push pinger-worker master'
  system 'git push pinger-scheduler master'

  system 'be heroku ps --app pinger-web'
  system 'be heroku ps --app pinger-worker'
  system 'be heroku ps --app pinger-scheduler'
end