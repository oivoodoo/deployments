# Capistrano Recipes for managing delayed_job

Capistrano::Configuration.instance.load do
  after 'deploy:migrations', 'deployments:push'
  after 'deploy',            'deployments:push'

  namespace :deployments do
    task :push do
      run <<-CMD
        cd #{current_path}/public && ln -s #{shared_path}/public/version.txt version.txt
      CMD

      run <<-CMD
        cd #{current_path} && rake deployments:push app_env=#{rails_env}
      CMD
    end
  end
end

