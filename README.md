# Jsontocsv

This Ruby lib aims at converting JSON files composed of arrays of objects (all following the same schema) into CSV files where one line equals one object.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jsontocsv_MJG'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install jsontocsv_MJG

## Usage
### From the console

    $ jsontocsv convert data/users.json

This will convert your JSON into a CSV file, generated right in the directory from which your calling the method.

### From your ruby file
```ruby
require 'jsontocsv'

JsonToCsv::Convert.convert('your_file.json')
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/salahalaoui/jsontocsv.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## How to test it

use:

    $ bundle exec rspec spec
or:

    $ rake spec

results :

    $ Jsontocsv
    $ CLI displays help
    $ CLI displays convert help
    $ CLI displays version help
    $ CLI converts file

    $ Jsontocsv::Convert
    $ can load json file
    $ can get recursive keys
    $ output csv file from an array of hash
    $ can convert json file to csv
    $ can convert multiple json files to csv files

    $ Jsontocsv
    $ has a version number

    $ Finished in 1.11 seconds (files took 0.10799 seconds to load)
    $ 10 examples, 0 failures
