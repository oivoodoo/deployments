require 'spec_helper'

include Deployments

describe PublicVersion do
  let(:project_path) { './spec/fixtures/repositories/tags/dot_git' }
  let(:project) { Project.new(project_path) }
  let(:public_version) { PublicVersion.new(project) }

  before { stub_repository }

  context "on generate version.txt" do
    before { public_version.generate }

    after { File.delete(VERSION_FILE) }

    it "should create file in public folder" do
      File.exists?(VERSION_FILE).should be_true
    end

    it "should contain the latest tag of the repository" do
      File.read(VERSION_FILE).should == "1.15.1"
    end
  end
end

