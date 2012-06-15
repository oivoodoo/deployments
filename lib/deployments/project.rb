require 'grit'
require 'versionomy'

module Deployments
  class Project
    attr_reader :path, :repo, :tags

    def initialize(path)
      @path = path
      @repo = Grit::Repo.new(path)

      versions = @repo.tags.map do |tag|
        Versionomy.parse(tag.name)
      end.sort

      @tags = versions.map {|v| v.to_s}
    end

    def commits
      commits = between_tags(repo) if has_commits_between_tags?

      (commits || repo.commits).inject({}) do |hash, commit|
        hash[commit.id] = commit.message
        hash
      end
    end

    def tag
      tags.last if has_tags?
    end

    private

    def between_tags(repo)
      previous = find_repo_tag(tags[tags.size - 2])
      last = find_repo_tag(tags.last)

      repo.commits_between(previous.commit.id, last.commit.id)
    end

    def find_repo_tag(name)
      repo.tags.find {|t| t.name == name}
    end

    def has_commits_between_tags?
      tags.size > 1
    end

    def has_tags?
      not tags.empty?
    end
  end
end

