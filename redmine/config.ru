# This file is used by Rack-based servers to start the application.
require ::File.expand_path('../config/environment',  __FILE__)
require 'unicorn'
require 'unicorn/worker_killer'

if defined?(Unicorn)

  min = (ENV['UNICORN_WOKER_KILLER_MEMORY_MIN'] || 192 ).to_i
  max = (ENV['UNICORN_WOKER_KILLER_MEMORY_MAX'] || 256 ).to_i
  cycle = (ENV['UNICORN_WOKER_KILLER_CHECK_CYCLE'] || 16 ).to_i

  case ENV['UNICORN_WOKER_KILLER_VERBOSE']
    when 1, "1"
      verbose = true
    else
      verbose = false
  end

  use Unicorn::WorkerKiller::Oom, (min*(1024**2)), (max*(1024**2)), cycle, verbose
end

run RedmineApp::Application