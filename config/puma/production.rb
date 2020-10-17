#!/usr/bin/env puma

directory '/var/www/applications/scuria/current'
environment 'production'

tag ''

pidfile "/var/www/applications/scuria/shared/tmp/pids/puma.pid"
state_path "/var/www/applications/scuria/shared/tmp/pids/puma.state"
stdout_redirect '/var/www/applications/scuria/shared/log/puma_access.log', '/var/www/applications/scuria/shared/log/puma_error.log', true

bind 'tcp://127.0.0.1:3001'

threads 0, 2
workers 2


prune_bundler

on_restart do
  puts 'On restart'
end
