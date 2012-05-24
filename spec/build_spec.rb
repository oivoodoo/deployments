require 'spec_helper'

include Deployments

describe Build do
  let(:build) { Build.new("staging") }

  describe "interface for getting build information as json params" do
    it "should return deployer name information" do
      Etc.should_receive(:getlogin).and_return("john.smith")
      build.to_params[:username].should == "john.smith"
    end

    it "should return env" do
      build.should_receive(:env).twice.and_return("staging")
      build.to_params[:env].should == "staging"
    end

    it "should return domain by env" do
      build.should_receive(:domain).and_return("staging.example.com")
      build.to_params[:domain].should == "staging.example.com"
    end

    context "in the current git project" do
      let(:project_path) { './spec/fixtures/repositories/commits_tag/dot_git' }

      before do
        @repo = Grit::Repo.new(project_path, :is_bare => true)
        Grit::Repo.should_receive(:new).and_return(@repo)

        @project = Project.new(project_path)
        Project.should_receive(:new).and_return(@project)
      end

      it "should return current tag of the git project" do
        build.to_params[:tag].should == "0.0.1"
      end

      it "should return commits of the git project between the latests tags" do
        build.to_params[:commits].should == [
          "Added deployments section to the README file",
          "Added README file"
        ]
      end
    end
  end
end

