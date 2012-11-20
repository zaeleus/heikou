# Heikou

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'heikou'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install heikou

## Usage

TODO: Write usage instructions here

### Example

    require 'heikou'

    Heikou::CL.create do |cl|
      source = File.read('/tmp/vecadd.cl')
      vecadd = cl.create_program(source).to_kernel

      a = b = (0...4096).map(&:float)
      c = cl.create_buffer :float, 4096

      vecadd[a, b, c]

      p c.to_a
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
