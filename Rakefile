begin
  require 'bundler/gem_tasks'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task default: :spec

rescue LoadError
  puts 'RSpec not found. Did you `bundle install`?'
end
