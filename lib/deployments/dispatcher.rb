require 'curb'

module Deployments
  class Dispatcher
    attr_reader :build

    def initialize(build)
      @build = build
    end

    def run
    end
  end
end

