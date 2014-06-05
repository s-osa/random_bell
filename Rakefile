require "bundler/gem_tasks"
require "rspec/core/rake_task"

# Exclude histogram specs by default
RSpec::Core::RakeTask.new("spec") do |task|
  task.rspec_opts = "--tag ~histogram"
end

RSpec::Core::RakeTask.new("spec:histogram")

task default: [:spec]


