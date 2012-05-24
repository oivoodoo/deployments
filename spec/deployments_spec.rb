require 'spec_helper'

describe Deployments do
  context "getting access to the configuration" do
    it "should get server url" do
      Deployments.options.server.should == "example.com"
    end

    it "should get domain for env" do
      Deployments.staging.domain == "staging.example.com"
    end
  end
end

