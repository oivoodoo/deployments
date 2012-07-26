# Deployments

Library for pushing details(commits, tag, username, env) about the current app

[![Build Status](https://secure.travis-ci.org/oivoodoo/deployments.png?branch=master)](http://travis-ci.org/oivoodoo/deployments)

## Installation

Add this line to your application's Gemfile:

    gem 'deployments'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install deployments

## Usage

If you are using Rails 2 or non Rails gem you should add the next following
code into Rakefile:

```ruby
  require 'deployments/gem_tasks'
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

  after 'deploy' do
    run <<-CMD
      rake deployments:push app_env=your_app_env
    CMD
  end
```

Request params:
```ruby
  {
    {
      :author => "author",
      :commit_attributes => {
        "commit id" => {
          "message" => "Add readme file",
          "created_at" => "2012-05-23 10:38:46 +0300"
        },
        "commit id" => {
          "message" => "Change readme file",
          "created_at" => "2012-05-23 10:39:18 +0300"
        }
      },
      :env => "staging",
      :version => "1.0.1",
      :host_name => "staging.example.com"
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

Now you can get request version.txt file from public folder, it will show the
latest tag name of the project.

```
  http://your-site/version.txt
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
