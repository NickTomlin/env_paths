EnvPaths ![Build Status](https://travis-ci.org/NickTomlin/env_paths.png?branch=master) [![Gem Version](https://badge.fury.io/rb/env_paths.svg)](https://badge.fury.io/rb/env_paths)
===

Provides OS specific paths for your gem/application. A ruby port of [`env-paths`](https://github.com/sindresorhus/env-paths).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'env_paths'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install env_paths

## Usage

```ruby
paths = EnvPaths.get('my_app')

paths.temp
# => /var/folders/82/6j4l32lj4_g09w60_vjxh09h392d05/T/my_app-ruby

paths.config
# => /Users/your_user/Library/Preferences/my_app-ruby
```

### Options

`suffix`

If there is a conflict with a native application and the default suffix (`ruby`), you can pass a `suffix` key in the options hash:

```ruby
paths = EnvPaths.get('my_app', suffix: 'my_suffix')

paths.temp
# => /var/folders/82/6j4l32lj4_g09w60_vjxh09h392d05/T/my_app-my_suffix

```

Or disable it entirely by passing `false`:

```ruby
paths = EnvPaths.get('my_app', suffix: false)

paths.temp
# => /var/folders/82/6j4l32lj4_g09w60_vjxh09h392d05/T/my_app

```

## Contributing

1. Fork it ( https://github.com/nicktomlin/env_paths/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Run the tests `rake`
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
