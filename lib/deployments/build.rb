require 'etc'

module Deployments
  class Build
    attr_reader :env, :project

    def initialize(env)
      @env = env
      @project = Project.new('./')
    end

    def to_params
      {
        :author => username,
        :env => env,
        :version  => tag,
        :commits => commits,
        :domain => domain
      }
    end

    private

    def username
      Etc.getlogin
    end

    def commits
      project.commits
    end

    def tag
      project.tag
    end

    def domain
      Deployments.send(env.to_sym).domain
    end
  end
end

