require 'curb'

module Deployments
  class Dispatcher
    attr_reader :build

    def initialize(build)
      @build = build
    end

    def run
      Curl::Easy.post(build.to_params)
    end
  end
end

