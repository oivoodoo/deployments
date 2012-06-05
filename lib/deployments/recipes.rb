# Capistrano Recipes for managing delayed_job

Capistrano::Configuration.instance.load do
  before 'deploy' do
    system <<-CMD
      rake deployments:push app_env=#{rails_env}
    CMD
  end
end

