# LinkedIn 2
[![Build Status](https://travis-ci.org/bobbrez/linkedin2.png?branch=master)](https://travis-ci.org/bobbrez/linkedin2)
[![Code Climate](https://codeclimate.com/github/bobbrez/linkedin2.png)](https://codeclimate.com/github/bobbrez/linkedin2)

A modernized LinkedIn Ruby client.

## Installation

Add this line to your application's Gemfile:

    gem 'linkedin2'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install linkedin2

## Usage

### Client Configuration

Configure an instance directly with a hash:

```ruby
client = LinkedIn::Client.new key: <your-key>, secret: <your-secret>,
redirect_uri: <your-callback>, scope: %i(r_basicprofile r_network)
```

Or configure an instance directly with the configure method:
```ruby
client = LinkedIn::Client.new
client.configure do |config|
  config.key = <your-key>
end
client.key # => <your-key>
```

Or configure the gem with a hash:

```ruby
LinkedIn::Client.configure  key: <your-key>, secret: <your-secret>, redirect_uri: <your-callback>
client = LinkedIn::Client.new
client.key # => <your-key>
```

Or configure the gem with a block:

```ruby
LinkedIn::Client.configure do |config|
  config.key = '<your-key>'
end
client = LinkedIn::Client.new
client.key # => <your-key>
```

### Authentication

Following the [LinkedIn Authentication Documentation](http://developer.linkedin.com/documents/authentication):

*Step 1. Register your application*

Create a LinkedIn Account and register an application

*Step 2a. Generate Authorization Code by redirecting user to LinkedIn's authorization dialog*

```ruby
# create a client and configure it with your :key, :secret and :redirect_uri. See "Client Configuration" above.
client.authorize_url # => A URI that will take a user to LinkedIn, ask them to login and redirect to the URI that you configured
```

*Step 2b. Request Access Token by exchanging the authorization_code for it*

```ruby
# create a client and configure it with your :key, :secret and :redirect_uri. See "Client Configuration" above.
client.request_access_token '<token-from-response>'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
