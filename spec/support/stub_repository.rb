def stub_repository
  @repo = Grit::Repo.new(project_path, :is_bare => true)
  Grit::Repo.should_receive(:new).and_return(@repo)
end

