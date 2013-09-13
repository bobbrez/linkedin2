# LinkedIn 2

A modernized LinkedIn Ruby client.

## Installation

Add this line to your application's Gemfile:

    gem 'linkedin'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install linkedin

## Usage

### Client Configuration

Configure an instance directly with a hash:

```ruby
client = LinkedIn::Client.new key: <your-key>, secret: <your-secret>, redirect_uri: <your-callback>
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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request