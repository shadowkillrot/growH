# config/puma.rb

max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { "development" }
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Recommended for Heroku (auto scales based on dynos)
workers ENV.fetch("WEB_CONCURRENCY") { 2 }

preload_app!

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart

# Optional: Run Solid Queue only in single-server setups
plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"]
