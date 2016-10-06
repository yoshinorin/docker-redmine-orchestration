worker_processes 1
listen  "3000" 
pid     '/tmp/unicorn.pid'
stderr_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
stdout_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
