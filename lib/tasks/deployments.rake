require 'deployments'
require 'rake'

include Rake::DSL if defined?(Rake::DSL)

namespace :deployments do

  desc "Push deployments details to the server"
  task :push do
    build = Build.new(ENV['deployment_env'])
    dispatcher = Deployments::Dispatcher.new(build)
    dispatcher.run
  end
end

