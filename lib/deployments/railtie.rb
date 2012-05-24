require 'rails'

module Deployments

  class Railtie < Rails::Railtie
    railtie_name :deployments

    rake_tasks do
      load File.join(File.dirname(__FILE__),"../tasks/deployments.rake")
    end
  end
end

