require 'spec_helper'

include Deployments

describe Dispatcher do
  let(:build) { Build.new("staging") }
  let(:dispatcher) { Dispatcher.new(build) }

  context "post deployment data" do
    before do
      Curl::Easy.should_receive(:http_post).and_return(response)

      build.should_receive(:to_params).and_return(fields)
    end

    context "with valid data" do
      let(:response) { double('response', :response_code => 200) }
      let(:fields) do
        {
          :username => "john.smith",
          :env => "staging",
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
      let(:fields) { { :key => "invalid value" } }
      let(:response) { double('response', :response_code => 500) }

      it "should unlucky send" do
        dispatcher.run.should be_false
      end
    end
  end

  def curl_fields
    fields.map do |key, value|
      Curl::PostField.content(key, value)
    end
  end
end

