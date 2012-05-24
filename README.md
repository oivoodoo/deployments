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

At first you need to create in the config folder deployments.yml file with
line:

```yaml
  server: "your deployments server that will save build version"
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


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
