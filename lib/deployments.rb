require "deployments/version"
require "deployments/project"
require "deployments/build"
require "deployments/dispatcher"

require 'simple-conf'

module Deployments
  class Options
    include SimpleConf
  end
end

