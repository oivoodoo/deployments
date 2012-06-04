require 'spec_helper'

describe Deployments do
  context "getting access to the configuration" do
    it "should get server url" do
      Deployments.options.server.should == "example.com"
    end

    it "should get domain for env" do
      Deployments.staging.domain == "staging.example.com"
    end

    it "should get api key of the app" do
      Deployments.staging.api_key.should == "api key"
    end
  end
end

