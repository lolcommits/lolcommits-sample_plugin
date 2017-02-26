# Lolcommits Sample Plugin

lolcommits takes a snapshot with your webcam every time you git commit code, and
archives a lolcat style image with it. Git blame has never been so much fun!

Lolcommit plugins are automatically loaded before the capturing process starts
and the flexible class design allows developers to write their own code to
execute before or after snapshots are taken.

This gem serves as a basic working example (using the post-capture hook). It
simply prints a short message to the screen after every commit. It has good test
coverage, documentation and is a great starting point for anyone building their
own plugin.

See below for more information on how to get started.

## Requirements

* Ruby >= 2.0.0
* A webcam
* [ImageMagick](http://www.imagemagick.org)
* [ffmpeg](https://www.ffmpeg.org) (optional) for animated gif capturing

## Installation

Follow the main lolcommits README for installation and requirements. Then after
installing and setting up lolcommits, run the following to install this plugin:

    $ gem install lolcommits-plugin-sample

## Usage

After installing, configure this sample plugin with:

    $ lolcommits --config
    # or
    $ lolcommits --config -p plugin-sample

Set enabled as `true`, and every lolcommit capture now comes with a short and
snappy message!

## Developing your own plugin


## Tests

Run tests for this gem with:

    $ rake test

## Docs

Generate docs for this gem with:

    $ rake rdoc

## History

Until recently, our plugins lived inside the main lolcommits gem. We are
currently in the process of upgrading them all to use the newer gem based plugin
manager. This means each plugin can live in its own gem. Rubygem versioning can
then take care of managing compatibility with main gem.

## Contributing

Bug [reports](https://github.com/lolcommits/lolcommits-plugin-sample/issues) and [pull
requests](https://github.com/lolcommits/lolcommits-plugin-sample/pulls) are welcome on
GitHub.

When submitting pull requests, please remember to add tests covering the new
behaviour, and ensure all tests are passing on [Travis
CI](https://travis-ci.org/lolcommits/lolcommits-plugin-sample). Read the [contributing
guidelines](https://github.com/lolcommits/lolcommits-plugin-sample/CONTRIBUTING.md)
for more details.

This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [Contributor
Covenant](http://contributor-covenant.org) code of conduct. See
[here](https://github.com/lolcommits/lolcommits-plugin-sample/CODE_OF_CONDUCT.md)
for more details.

## Development

After checking out the repo, run `bin/setup`, this will install dependencies,
and generate docs. Then, run `bundle exec rake` to run all tests (and generate a
coverage report).

You can also run `bin/console` for an interactive prompt that will allow you to
experiment with the gem code.

## Troubles?

If you think something is broken or missing, do raise a new
[issue](https://github.com/lolcommits/lolcommits-plugin-sample/issues). Please
remember to take a moment and check it hasn't already been raised (and possibly
closed).

## License

The gem is available as open source under the terms of
[LGPL-3](https://opensource.org/licenses/LGPL-3.0).

## Links

* [Travis CI](https://travis-ci.org/lolcommits/lolcommits-plugin-sample)
* [Test Coverage](https://coveralls.io/r/matthutchinson/lifx_dash?branch=master)
* [Code Climate](https://codeclimate.com/github/matthutchinson/lifx_dash)
* [RDoc](http://rdoc.info/projects/matthutchinson/lifx_dash)
* [Issues](http://github.com/matthutchinson/lifx_dash/issues)
* [Report a bug](http://github.com/matthutchinson/lifx_dash/issues/new)
* [Gem](http://rubygems.org/gems/lifx_dash)
* [GitHub](http://github.com/matthutchinson/lifx_dash)
