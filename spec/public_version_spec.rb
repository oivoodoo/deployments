require 'spec_helper'

include Deployments

describe PublicVersion do
  let(:project_path) { './spec/fixtures/repositories/tags/dot_git' }
  let(:project) { Project.new(project_path) }
  let(:public_version) { PublicVersion.new(project) }

  before do
    @repo = Grit::Repo.new(project_path, :is_bare => true)
    Grit::Repo.should_receive(:new).and_return(@repo)
  end

  context "on generate version.txt" do
    before { public_version.generate }

    it "should create file in public folder" do
      File.exists?('./public/version.txt').should be_true
    end

    it "should contain the latest tag of the repository" do
      File.read('./public/version.txt').should == "1.15.1"
    end
  end
end

