module Deployments
  class PublicVersion
    def initialize(project)
      @project = project
    end

    def generate
      File.open('./public/version.txt', 'w') do |file|
        file.write @project.tags.last
      end
    end
  end
end

