require 'curb'

module Deployments
  class Dispatcher
    attr_reader :build

    def initialize(build)
      @build = build
    end

    def run
      c = Curl::Easy.http_post(Deployments.options.server, fields)

      c.response_code.to_i == 200
    end

    private

    def fields
      build.to_params.map do |key, value|
        if value.is_a?(Array)
          field_as_array(key, value)
        else
          Curl::PostField.content(key, value.to_s)
        end
      end.flatten
    end

    def field_as_array(key, value)
      value.map do |v|
        Curl::PostField.content("#{key}[]", v.to_s)
      end
    end
  end
end

