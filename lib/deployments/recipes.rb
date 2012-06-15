# Capistrano Recipes for managing delayed_job

Capistrano::Configuration.instance.load do
  after 'deploy:migrations' do
    logger.info "Run rake deployments:push app_env=#{rails_env} on deploy:migrations"

    sh <<-CMD
      rake deployments:push app_env=#{rails_env}
    CMD

    logger.info "Deployments push completed."
  end

  after 'deploy' do
    logger.info "Run rake deployments:push app_env=#{rails_env} on deploy"

    sh <<-CMD
      rake deployments:push app_env=#{rails_env}
    CMD

    logger.info "Deployments push completed."
  end
end

