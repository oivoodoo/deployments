require 'spec_helper'

include Deployments

describe Project do
  let(:project) { Project.new(project_path) }

  before { stub_repository }

  context "with one commit" do
    let(:project_path) { './spec/fixtures/repositories/one_commit/dot_git' }

    it "should be possible to get only commits" do
      project.commits.to_s.should include("Added README file")
    end

    it "should be possible to get creation date of commit" do
      project.commits.to_s.should include("2012-06-05 11:05:43 +0300")
    end

    it "should retrieve empty tag" do
      project.tag.should be_nil
    end
  end

  context "with only commits" do
    let(:project_path) { './spec/fixtures/repositories/commits/dot_git' }

    it "should be possible to get only commits" do
      project.commits.to_s.should include("Added deployments section to the README file")
      project.commits.to_s.should include("Added README file")
    end

    it "should be possible to get creation dates of commits" do
      project.commits.to_s.should include("2012-05-21 17:33:22 +0300")
      project.commits.to_s.should include("2012-05-21 17:32:57 +0300")
    end

    it "should retrieve empty tag" do
      project.tag.should be_nil
    end
  end

  context "with commits and one tag" do
    let(:project_path) { './spec/fixtures/repositories/commits_tag/dot_git' }

    it "should be possible to get commits" do
      project.commits.to_s.should include("Added deployments section to the README file")
      project.commits.to_s.should include("Added README file")
    end

    it "should retrieve the latest tag" do
      project.tag.should == "0.0.1"
    end
  end

  context "with commits between the latest tags" do
    let(:project_path) { './spec/fixtures/repositories/commits_tags/dot_git' }

    it "should be possible to get commits between tags" do
      project.commits.to_s.should include("Added config.rb file")
      project.commits.to_s.should include("Changed configuration for the app")
    end

    it "should retrieve the latest tag" do
      project.tag.should == "0.0.2"
    end
  end

  context "when we have version.txt file in public folder" do
    let(:project_path) { './spec/fixtures/repositories/tags/dot_git' }
    let(:tag_name) { "1.1.1" }

    before do
      File.open(VERSION_FILE, "w") do |file|
        file.write tag_name
      end
    end

    after { File.delete(VERSION_FILE) }

    it "should use version file for collecting commits" do
      project.commits.to_s.should include("Change readme file")
      project.commits.to_s.should include("Add empty space to readme file")
    end

    context "with empty characters at the end of tag name" do
      let(:tag_name) { "1.1.1\r\n" }

      it "should use version file for collecting commits" do
        project.commits.to_s.should include("Change readme file")
        project.commits.to_s.should include("Add empty space to readme file")
      end
    end
  end

  context "with one commit between tags" do
    let(:project_path) { './spec/fixtures/repositories/one_commit_tags/dot_git' }

    it "should be possible to get commits between tags" do
      project.commits.to_s.should include("Added config.rb file")
    end

    it "should retrieve the latest tag" do
      project.tag.should == "0.0.2"
    end
  end

  context "with various tags" do
    let(:project_path) { './spec/fixtures/repositories/tags/dot_git' }

    it "should return the latest tag" do
      project.tag.should == "1.15.1"
    end
  end
end

