# Capistrano Recipes for managing delayed_job

Capistrano::Configuration.instance.load do
  after 'deploy:migrations' do
    run <<-CMD
      cd #{current_path} && rake deployments:push app_env=#{rails_env}
    CMD
  end

  after 'deploy' do
    run <<-CMD
      cd #{current_path} && rake deployments:push app_env=#{rails_env}
    CMD
  end
end

