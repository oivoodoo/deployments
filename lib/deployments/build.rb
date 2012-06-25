require 'etc'

module Deployments
  class Build
    attr_reader :env, :project

    def initialize(env, project)
      @env = env
      @project = project
    end

    def to_params
      {
        :deployment => {
          :author => username,
          :env => env,
          :version  => tag,
          :commit_attributes => commits,
          :host_name => domain
        },
        :api_key => api_key
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
      settings.domain
    end

    def api_key
      settings.api_key
    end

    def settings
      Deployments.send(env.to_sym)
    end
  end
end

