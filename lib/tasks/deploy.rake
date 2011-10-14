task :deploy do
  system 'git push pinger-web master'
  system 'git push pinger-worker master'
  system 'git push pinger-scheduler master'
end