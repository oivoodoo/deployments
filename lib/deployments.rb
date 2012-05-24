require "deployments/version"
require "deployments/project"
require "deployments/build"
require "deployments/dispatcher"

require "deployments/railtie" if defined?(Rails) and Rails.version > "3.0.0"

require 'simple-conf'

module Deployments
  include SimpleConf
end

