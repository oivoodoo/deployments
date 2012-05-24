require 'spec_helper'

describe Deployments do
  context "getting access to the configuration" do
    it "should get server url" do
      Deployments.server.should == "example.com"
    end
  end
end

