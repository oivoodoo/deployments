require 'spec_helper'

include Deployments

describe Dispatcher do
  let(:build) { Build.new("staging") }
  let(:dispatcher) { Dispatcher.new(build) }

  context "post deployment data" do
    before do
      Curl::Easy.should_receive(:post).with(*fields).and_return(response)

      build.should_receive(:commits).and_return [
        "Added deployments section to the README file",
        "Added README file"
      ]
      build.should_receive(:tag).and_return("0.0.1")
    end

    context "with valid data" do
      let(:response) { double('response', :response_code => 200) }
      let(:fields) do
        {
          :env => "staging",
          :username => "john.smith",
          :tag => "0.0.1",
          :commits => [
            "Added deployments section to the README file",
            "Added README file"
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

