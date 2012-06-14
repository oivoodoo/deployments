# Deployments

Library for pushing details(commits, tag, username, env) about the current app

## Installation

Add this line to your application's Gemfile:

    gem 'deployments'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install deployments

## Usage

If you are using Rails 2 version you should add load method to your Rakefile:

```ruby
  load "#{Gem.searcher.find('deployments').full_gem_path}/lib/tasks/deployments.rake"
```

At first you need to create in the config folder deployments.yml file with
receiver server url and domains of different envs of your application:

```yaml
  options:
    server: "your deployments server that will save build version"
  development:
    domain: "development.example.com"
    api_key: "development api key"
  staging:
    domain: "staging.example.com"
    api_key: "staging api key"
```

Add to your capistrano recipes the next following line, changing your_app_env
to the deployment environment like 'staging' or 'development':

```ruby
  require 'deployments'

  before 'deploy' do
    sh <<-CMD
      rake deployments:push app_env=your_app_env
    CMD
  end
```

Request params:
```ruby
  {
    {
      :author => "author",
      :commit_attributes => [
        {
          "sha" => "commit id",
          "message" => "Add readme file",
        },
        {
          "sha" => "commit id",
          "message" => "Change readme file"
        }
      ],
      :env => "staging",
      :version => "1.0.1",
      :domain => "staging.example.com"
    },
    :api_key => "account api key"
  }
```

Also you can use capistrano recipes of the gem, you need to add:
```ruby
  require 'deployments/recipes'
```

It will add capistrano hook "after 'deploy'" for pushing deployment details to
the server after deploy.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
