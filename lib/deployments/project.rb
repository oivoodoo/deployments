require 'grit'

module Deployments
  class Project
    attr_reader :path, :repo

    def initialize(path)
      @path = path
      @repo = Grit::Repo.new(path)
    end

    def commits
      commits = between_tags(repo) if has_commits_between_tags?

      (commits || repo.commits).map do |commit|
        commit.message
      end
    end

    def tag
      repo.tags.last.name if has_tags?
    end

    private

    def between_tags(repo)
      last = repo.tags.last
      previous = repo.tags[repo.tags.size - 2]
      repo.commits_between(previous.commit.id, last.commit.id)
    end

    def has_commits_between_tags?
      repo.tags.size > 1
    end

    def has_tags?
      not repo.tags.empty?
    end
  end
end

