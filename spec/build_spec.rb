require 'spec_helper'

include Deployments

describe Build do
  let(:build) { Build.new }

  describe "interface for getting build information as json params" do
    it "should return deployer name information" do
      build.should_receive(:username).and_return("john.smith")
      build.to_params["username"].should == "john.smith"
    end

    it "should return env" do
      build.should_receive(:env).and_return("staging")
      build.to_params["env"].should == "staging"
    end

    it "should return current tag of the git project" do
      build.should_receive(:tag).and_return("1.0.1")
      build.to_params["tag"].should == "1.0.1"
    end

    context "in the current git project" do
      before do
        @project = Project.new('./spec/fixtures/repositories/commits')
      end

      it "should return commits of the git project between the latests tags" do
        build.should_receive(:commits).and_return([
          "Added README file",
          "Added deployments sections to the README file"
        ])
      end
    end
  end
end

