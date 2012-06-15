module Deployments
  class PublicVersion
    def initialize(project)
      @project = project
    end

    def generate
      File.open(VERSION_FILE, 'w') do |file|
        file.write @project.tag_names.last
      end
    end
  end
end

