environment 'production'
bind 'tcp://127.0.0.1:3001'
workers 2
threads 0, 2
daemonize true
pidfile "#{Dir.pwd}/tmp/pids/puma.pid"
state_path "#{Dir.pwd}/tmp/pids/puma.state"
directory '/var/www/applications/scuria/current'
