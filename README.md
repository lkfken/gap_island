# GapIsland

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/gap_island`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gap_island'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gap_island

## Usage

An element consists of 2 parts: attribute and date range

Define your attribute as such:
```ruby
attr = GapIsland::Attribute.new(obj)
```

Next, define your element:
```ruby
element1 =   GapIsland::Element.new(:attribute => attr, :date_range => Date.civil(2017, 1, 1)..Date.civil(2017, 1, 31))
element2 =   GapIsland::Element.new(:attribute => attr, :date_range => Date.civil(2017, 2, 1)..Date.civil(2017, 3, 31))
element3 =   GapIsland::Element.new(:attribute => attr, :date_range => Date.civil(2017, 6, 1)..Date.civil(2017, 8, 31))
```

Add these elements to a partition:
```ruby
partition = GapIsland::Partition.new([element1, element2, element3]) 
```

Last, give it a foundation:
```ruby
foundation = GapIsland::Foundation.new(:partition => partition, range: Date.civil(2000, 1, 1)..Date.civil(2020, 12, 31))
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gap_island.

