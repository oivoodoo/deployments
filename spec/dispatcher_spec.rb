require 'spec_helper'

include Deployments

describe Dispatcher do
  let(:project) { Project.new('./') }
  let(:build) { Build.new("staging", project) }
  let(:dispatcher) { Dispatcher.new(build) }

  before { build.should_receive(:to_params).and_return(fields) }

  describe "request params" do
    let(:response) { double('response', :response_code => 200) }
    let(:fields) do
      {
        :username => "james.bond",
        :params => ["fish", "cat"],
        :settings => {
          :url => "example.com",
          :key => "private",
          :values => [1, 2],
          :hashes => [
            {
              :a => "A",
              :b => "B"
            },
            {
              :c => "C",
              :d => "D"
            }
          ]
        }
      }
    end

    it "should have right params in request" do
      Curl::Easy.should_receive(:http_post) do |url, fields|
        url.should == Deployments.options.server

        fields.count.should == 11
        fields[0].to_s.should == "username=james.bond"
        fields[1].to_s.should == "params%5B%5D=fish"
        fields[2].to_s.should == "params%5B%5D=cat"
        fields[3].to_s.should == "settings%5Burl%5D=example.com"
        fields[4].to_s.should == "settings%5Bkey%5D=private"
        fields[5].to_s.should == "settings%5Bvalues%5D%5B%5D=1"
        fields[6].to_s.should == "settings%5Bvalues%5D%5B%5D=2"
        fields[7].to_s.should == "settings%5Bhashes%5D%5B%5D%5Ba%5D=A"
        fields[8].to_s.should == "settings%5Bhashes%5D%5B%5D%5Bb%5D=B"
        fields[9].to_s.should == "settings%5Bhashes%5D%5B%5D%5Bc%5D=C"
        fields[10].to_s.should == "settings%5Bhashes%5D%5B%5D%5Bd%5D=D"

        response
      end

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

