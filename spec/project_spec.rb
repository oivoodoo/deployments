require 'spec_helper'

include Deployments

describe Project do
  let(:project) { Project.new(project_path) }

  before do
    @repo = Grit::Repo.new(project_path, :is_bare => true)
    Grit::Repo.should_receive(:new).and_return(@repo)
  end

  context "with only commits" do
    let(:project_path) { './spec/fixtures/repositories/commits/dot_git' }

    it "should be possible to get only commits" do
      project.commits.should == [
        "Added deployments section to the README file",
        "Added README file"
      ]
    end

    it "should retrieve empty tag" do
      project.tag.should be_nil
    end
  end

  context "with commits and one tag" do
    let(:project_path) { './spec/fixtures/repositories/commits_tag/dot_git' }

    it "should be possible to get commits" do
      project.commits.should == [
        "Added deployments section to the README file",
        "Added README file"
      ]
    end

    it "should retrieve the latest tag" do
      project.tag.should == "0.0.1"
    end
  end

  context "with commits between the latest tags" do
    let(:project_path) { './spec/fixtures/repositories/commits_tags/dot_git' }

    it "should be possible to get commits between tags" do
      project.commits.should == [
        "Added config.rb file",
        "Changed configuration for the app"
      ]
    end

    it "should retrieve the latest tag" do
      project.tag.should == "0.0.2"
    end
  end
end

