require 'spec_helper'

include Deployments

describe Build do
  let(:project_path) { './spec/fixtures/repositories/commits_tag/dot_git' }
  let(:project) { Project.new(project_path) }
  let(:build) { Build.new("staging", project) }

  before { stub_repository }

  describe "interface for getting build information as json params" do
    let(:params) { build.to_params[:deployment] }

    it "should return deployer name information" do
      Etc.should_receive(:getlogin).and_return("john.smith")
      params[:author].should == "john.smith"
    end

    it "should return env" do
      build.should_receive(:env).exactly(3).and_return("staging")
      params[:env].should == "staging"
    end

    it "should return domain by env" do
      build.should_receive(:domain).and_return("staging.example.com")
      params[:host_name].should == "staging.example.com"
    end

    it "should return api key dedicated to the env" do
      build.to_params[:api_key].should == 'api key'
    end

    context "in the current git project" do
      it "should return current tag of the git project" do
        params[:version].should == "0.0.1"
      end

      it "should return commits of the git project between the latests tags" do
        hash = {}
        hash["dc7671f8a112706b6ee2404bae958fb8079dbda0"] = {
          :message => "Added deployments section to the README file",
          :created_at=> "2012-05-23 10:39:18 +0300"
        }
        hash["45bedbc8cbb57792e00ad8dd9c9e7740ff3c2da5"] = {
          :message => "Added README file",
          :created_at => "2012-05-23 10:38:46 +0300"
        }

        params[:commit_attributes].should == hash
      end
    end
  end
end

