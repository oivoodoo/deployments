require 'grit'
require 'versionomy'

module Deployments
  class Project
    attr_reader :path, :repo, :tag_names

    def initialize(path)
      @path = path
      @repo = Grit::Repo.new(path)

      versions = @repo.tags.map do |tag|
        Versionomy.parse(tag.name)
      end.sort

      @tag_names = versions.map {|v| v.to_s}
    end

    def commits
      commits = between_tags(repo) if has_commits_between_tags?

      (commits || repo.commits).inject({}) do |hash, commit|
        hash[commit.id] = {
          :message => commit.message,
          :created_at => commit.date.to_s
        }
        hash
      end
    end

    def tag
      tag_names.last if has_tags?
    end

    def previous_tag
      tag_name = File.read(VERSION_FILE).strip if File.exists?(VERSION_FILE)
      tag_name ||= tag_names[tag_names.size - 2]

      find_repo_tag(tag_name)
    end

    private

    def between_tags(repo)
      last = find_repo_tag(tag_names.last)

      repo.commits_between(previous_tag.commit.id, last.commit.id)
    end

    def find_repo_tag(name)
      repo.tags.find {|t| t.name == name}
    end

    def has_commits_between_tags?
      tag_names.size > 1
    end

    def has_tags?
      not tag_names.empty?
    end
  end
end

