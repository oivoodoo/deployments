require 'spec_helper'

include Deployments

describe Dispatcher do
  let(:build) { Build.new("staging") }
  let(:dispatcher) { Dispatcher.new(build) }

  before { build.should_receive(:to_params).and_return(fields) }

  describe "request params" do
    let(:response) { double('response', :response_code => 200) }
    let(:fields) do
      {
        :username => "james.bond",
        :params => ["fish", "cat"]
      }
    end

    it "should have right params in request" do
      Curl::Easy.should_receive(:http_post) do |url, fields|
        url.should == Deployments.options.server

        fields.count.should == 3
        fields[0].should == "username=james.bond"
        fields[1].should == "params[]=fish"
        fields[2].should == "params[]=cat"
      end.and_return(response)

      dispatcher.run
    end
  end

  context "post deployment data" do
    before { Curl::Easy.should_receive(:http_post).and_return(response) }

    context "with valid data" do
      let(:response) { double('response', :response_code => 200) }
      let(:fields) { { } }

      it "should successfully send" do
        dispatcher.run.should be_true
      end
    end

    context "with invalid data" do
      let(:fields) { { :key => "invalid value" } }
      let(:response) { double('response', :response_code => 500) }

      it "should unlucky send" do
        dispatcher.run.should be_false
      end
    end

    context "with invalid data" do
      let(:fields) { { :key => nil } }
      let(:response) { double('response', :response_code => 500) }

      it "should unlucky send" do
        dispatcher.run.should be_false
      end
    end
  end
end

