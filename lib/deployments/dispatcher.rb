require 'curb'

module Deployments
  class Dispatcher
    attr_reader :build

    def initialize(build)
      @build = build
    end

    def run
      c = Curl::Easy.http_post(Deployments.server, fields)

      c.response_code.to_i == 200
    end

    private

    def fields
      build.to_params.map do |key, value|
        Curl::PostField.content(key, value)
      end
    end
  end
end

