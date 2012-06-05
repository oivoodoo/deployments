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
        build_field(key, value)
      end.flatten
    end

    def build_field(key, value)
      if value.is_a?(Array)
        field_as_array(key, value)
      elsif value.is_a?(Hash)
        field_as_hash(key, value)
      else
        Curl::PostField.content(key, value.to_s)
      end
    end

    def field_as_hash(key, value)
      value.map do |k, v|
        build_field("#{key}[#{k}]", v)
      end
    end

    def field_as_array(key, value)
      value.map do |v|
        Curl::PostField.content("#{key}[]", v.to_s)
      end
    end
  end
end

