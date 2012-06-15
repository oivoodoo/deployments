require 'deployments'
require 'rake'

include Rake::DSL if defined?(Rake::DSL)
include Deployments

namespace :deployments do
  desc "Push deployments details to the server"
  task :push do
    project = Project.new('./')
    build = Build.new(ENV['app_env'], project)

    dispatcher = Dispatcher.new(build)
    dispatcher.run

    public_version = PublicVersion.new(project)
    public_version.generate
  end
end

