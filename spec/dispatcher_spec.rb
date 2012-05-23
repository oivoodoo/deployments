require 'spec_helper'

include Deployments

describe Dispatcher do
  let(:build) { Build.new }
  let(:dispatcher) { Dispatcher.new(build) }

  context "post deployment data" do
    before do
      Curl::Easy.should_receive(:post).with(*fields).and_return(response)
    end

    context "with valid data" do
      let(:response) { double('response', :response_code => 200) }
      let(:fields) do
        {
          :env => "staging",
          :domain => "client.example.com",
          :username => "john.smith",
          :tag => "1.0.1",
          :commits => [
            "Added README file",
            "Added deployments section to the README file"
          ]
        }
      end

      it "should successfully send" do
        dispatcher.run.should be_true
      end
    end

    context "with invalid data" do
      let(:fields) { "invalid param" }
      let(:response) { double('response', :response_code => 500) }

      it "should unlucky send" do
        dispatcher.run.should be_false
      end
    end
  end

end
