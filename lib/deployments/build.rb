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
        :username => username,
        :env => env,
        :tag => tag,
        :commits => commits
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
  end
end

