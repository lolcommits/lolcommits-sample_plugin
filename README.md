# Lolcommits Plugin Sample

[![Gem Version](https://img.shields.io/gem/v/lolcommits-plugin-sample.svg?style=flat)](http://rubygems.org/gems/lolcommits-plugin-sample)
[![Travis Build Status](https://travis-ci.org/lolcommits/lolcommits-plugin-sample.svg?branch=master)](https://travis-ci.org/lolcommits/lolcommits-plugin-sample)
[![Coverage Status](https://coveralls.io/repos/github/lolcommits/lolcommits-plugin-sample/badge.svg?branch=master)](https://coveralls.io/github/lolcommits/lolcommits-plugin-sample)
[![Code Climate](https://codeclimate.com/github/lolcommits/lolcommits-plugin-sample/badges/gpa.svg)](https://codeclimate.com/github/lolcommits/lolcommits-plugin-sample)
[![Gem Dependency Status](https://gemnasium.com/badges/github.com/lolcommits/lolcommits-plugin-sample.svg)](https://gemnasium.com/github.com/lolcommits/lolcommits-plugin-sample)

[lolcommits](https://lolcommits.github.io/) takes a snapshot with your webcam
every time you git commit code, and archives a lolcat style image with it. Git
blame has never been so much fun!

lolcommit plugins are automatically loaded before the capturing process starts.
The flexible class design allows developers to add features, running code before
or after snapshots are taken.

This gem showcases an example plugin (using the post-capture hook). It prints a
short message to the screen after every lolcommit. Something like this;

    ✨  wow! 9e6303c is your best looking commit yet! 😘  💻

Use this repo to jump-start development on your own plugin. It has good tests,
docs and working hooks to useful tools (Travis, CodeClimate, Rdoc etc.) See
below for more information on how to get started.

## Developing your own plugin

TBA.

## History

Until recently, all plugins lived inside the main lolcommits gem. We are in the
process of extracting them to inidividual gems, loaded with the new plugin
manager. Rubygems versioning can then take care of managing dependencies and
compatibility with the main gem.

## Requirements

* Ruby >= 2.0.0
* A webcam
* [ImageMagick](http://www.imagemagick.org)
* [ffmpeg](https://www.ffmpeg.org) (optional) for animated gif capturing

## Installation

Follow the [install guide](https://github.com/mroth/lolcommits#installation) for
lolcommits first. Then run the following:

    $ gem install lolcommits-plugin-sample

Next configure and enable this plugin with:

    $ lolcommits --config
    # or
    $ lolcommits --config -p plugin-sample
    # set enabled to `true`

Thats it! Every lolcommit now comes with it's own short (emoji themed) message!

## Development

After checking out the repo, run `bin/setup`, this will install dependencies,
and generate docs. Then, run `bundle exec rake` to run all tests (and generate a
coverage report).

You can also run `bin/console` for an interactive prompt that will allow you to
experiment with the gem code.

## Tests

Run tests with:

    $ rake test

Minitest is used for testing. The main lolcommits gem provides helper modules to
work with IO and Git repos in test. Use them in your test setup code, to fake
user input or capture STDOUT.

    # add this to your test_helper
    require 'lolcommits/test_helpers/git_repo'
    require 'lolcommits/test_helpers/fake_io'

    # and include this module in your test
    include Lolcommits::TestHelpers::GitRepo
    include Lolcommits::TestHelpers::FakeIO

See the existing tests and module code for the helper methods available.

## Docs

Generate docs for this gem with:

    $ rake rdoc

## Troubles?

If you think something is broken or missing, do raise a new
[issue](https://github.com/lolcommits/lolcommits-plugin-sample/issues). Please
take a moment to check it hasn't been raised in the past (and possibly closed).

## Contributing

Bug [reports](https://github.com/lolcommits/lolcommits-plugin-sample/issues) and [pull
requests](https://github.com/lolcommits/lolcommits-plugin-sample/pulls) are welcome on
GitHub.

When submitting pull requests, please remember to add tests covering any new
behaviour, and ensure all tests are passing on [Travis
CI](https://travis-ci.org/lolcommits/lolcommits-plugin-sample). Read the [contributing
guidelines](https://github.com/lolcommits/lolcommits-plugin-sample/blob/master/CONTRIBUTING.md)
for more details.

This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [Contributor
Covenant](http://contributor-covenant.org) code of conduct. See
[here](https://github.com/lolcommits/lolcommits-plugin-sample/blob/master/CODE_OF_CONDUCT.md)
for more details.

## License

The gem is available as open source under the terms of
[LGPL-3](https://opensource.org/licenses/LGPL-3.0).

## Links

* [Travis CI](https://travis-ci.org/lolcommits/lolcommits-plugin-sample)
* [Test Coverage](https://coveralls.io/github/lolcommits/lolcommits-plugin-sample?branch=master)
* [Code Climate](https://codeclimate.com/github/lolcommits/lolcommits-plugin-sample)
* [RDoc](http://rdoc.info/projects/lolcommits/lolcommits-plugin-sample)
* [Issues](http://github.com/lolcommits/lolcommits-plugin-sample/issues)
* [Report a bug](http://github.com/lolcommits/lolcommits-plugin-sample/issues/new)
* [Gem](http://rubygems.org/gems/lolcommits-plugin-sample)
* [GitHub](https://github.com/lolcommits/lolcommits-plugin-sample)
