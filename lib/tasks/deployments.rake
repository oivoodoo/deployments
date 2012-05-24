require 'deployments'
require 'rake'

include Rake::DSL if defined?(Rake::DSL)

namespace :deployments do

  desc "Push deployments details to the server"
  task :push do
    build = Deployments::Build.new(ENV['app_env'])
    dispatcher = Deployments::Dispatcher.new(build)
    dispatcher.run
  end
end

