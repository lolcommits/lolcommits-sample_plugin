# Lolcommits Sample Plugin

[![Build](https://img.shields.io/github/actions/workflow/status/lolcommits/lolcommits-sample_plugin/build.yml?branch=main&style=flat)](https://github.com/lolcommits/lolcommits-sample_plugin/actions/workflows/build.yml)
[![Gem](https://img.shields.io/gem/v/lolcommits-sample_plugin.svg?style=flat)](http://rubygems.org/gems/lolcommits-sample_plugin)
[![Depfu](https://img.shields.io/depfu/lolcommits/lolcommits-sample_plugin.svg?style=flat)](https://depfu.com/github/lolcommits/lolcommits-sample_plugin)

[lolcommits](https://lolcommits.github.io/) takes a snapshot with your
webcam every time you git commit code, and archives a lolcat style image
with it. Git blame has never been so much fun!

Lolcommit plugins allow developers to add features by running code
before or after snapshots are taken. Installed plugin gems are
automatically loaded before the capturing process starts.

This gem showcases an example plugin. It prints short messages to the
screen before and after every lolcommit. After configuring the plugin to
be enabled, you'll see something like this for a capture:

    ✨  Say cheese 😁 !
    *** Preserving this moment in history.
    📸  Snap
    wow! 9e6303c at /path/to/lolcommit.jpg is your best looking commit yet!
    (it was an image!)

Use this repo to jump-start development on your own plugin. It has
tests, docs and hooks with useful tools; CI, Rdoc etc.

## Developing your own plugin

First, there are some things your gem *must* do to be loaded and
executed:

* The gem name must have a `lolcommits-` prefix.
* Require `lolcommits` in your `gemspec` file as a development
  dependency.
* Include a class that inherits from `Lolcommits::Plugin::Base` (this
  will be the entry point to your plugin from the lolcommits gem).
* This main plugin class must meet the requirements explained below.

### Your Plugin Class

You plugin class must have a namespace and path that matches your gem
name and be in the gem's `LOAD_PATH`.

    # for a gem named lolcommits-zapier you should have a plugin class:
    class Lolcommits::Plugin::Zapier < Lolcommits::Plugin::Base
      ...
    end
    # at lib/lolcommits/plugin/zapier.rb
    # required in a file at lib/lolcommits/zapier.rb

    # or a gem named lolcommits-super_awesome should have a plugin class:
    class Lolcommits::Plugin::SuperAwesome < Lolcommits::Plugin::Base
      ...
    end
    # at lib/lolcommits/plugin/super_awesome.rb
    # required in a file at lib/lolcommits/super_awesome.rb

The following methods can be overridden to execute code during the
capture process:

* `run_pre_capture` - executes before the capture starts, at this point
  you could alter the commit message/sha text.
* `run_post_capture` - executes immediately after the camera captures,
  use this hook to manipulate the image (e.g. resize, apply filters,
  annotate).
* `run_capture_ready` - executes after all `run_post_capture` hooks have
  ran, at this point we consider the capture to be ready for exporting
  or sharing.

### Plugin configuration

Available options can be defined in an Array (`@options` instance var)
and/or a Hash (by overriding the `default_options` method).

By default (on initialize), `@options` will be set to `[:enabled]`. This
option is mandatory since `enabled?` checks `configuration[:enabled] ==
true` before any capture hooks can run.

Using a Hash to define default options allows you to:

- fall back to default values (or nil) if the user enters nothing when
  prompted
- define nested options (the user is prompted for each nested option
  key)

`configure_option_hash` will iterate over all options prompting the user
for input while building the configuration Hash.

Lolcommits will save this Hash to a YAML file. During the capture
process the configuration is loaded, parsed and available in the plugin
class as `configuration`. Or if you want to fall back to default values,
you should use the `config_option` method to dig into the Hash.

Alternatively you can override these methods to fully customise the
configuration process.

* `def configure_options!` - by default this prompts the user for option
  values (based on option names in the `@options` array and/or
  `default_options`) and returns a Hash that will be persisted.
* `def enabled?` - by default checks if `configuration[:enabled] ==
  true` to determine if the plugin should run.
* `def valid_configuration?`- checks the persisted config Hash is valid.

By default a plugin will only run it's capture hooks if:

* `valid_configuration?` returns true
* `enabled?` returns true

A `parse_user_input` method is available to help parse strings from
STDIN to Ruby objects (e.g. boolean, integer or nil).

During plugin configuration, your plugin class will be initialized with
the optional `config` argument (and no runner). This allows you to read
the existing saved options during configuration. E.g. to show existing
options back to the user, allowing you to ask if they want to keep or
change an option if reconfiguring.

__NOTE__: If your plugin does not require configuration and should be
enabled by default (on gem install) you could override the `enabled?`
method to always return `true`. Simply uninstalling the gem will disable
the plugin.

For more help, check out [the
documentation](http://www.rubydoc.info/github/lolcommits/lolcommits-sample_plugin/Lolcommits/Plugin/SamplePlugin)
for this plugin, or take a look at [other
  lolcommit_plugins](https://github.com/search?q=topic%3Alolcommits-plugin+org%3Alolcommits&type=Repositories)
  in the wild.

### The Lolcommits 'runner'

The only required argument for your plugin class initializer is a
[Lolcommits::Runner](https://github.com/lolcommits/lolcommits/blob/master/lib/lolcommits/runner.rb)
instance. By default, the base plugin initializer will set this in the `runner`
instance var for use in your plugin's code.

* `runner.message` - the commit message
* `runner.sha` - the sha for the current commit
* `runner.vcs_info` - a reference to the
  [Lolcommits::VCSInfo](https://github.com/lolcommits/lolcommits/blob/master/lib/lolcommits/vcs_info.rb)
  instance
* `runner.config` - a reference to the
  [Lolcommits::Configuration](https://github.com/lolcommits/lolcommits/blob/master/lib/lolcommits/configuration.rb)
  instance
* `runner.overlay` - blank transparent PNG (`MiniMagick::Image` instance)
* `runner.lolcommits_path` - the processed lolcommit file path (jpg, mp4 or gif)
* `runner.lolcommits_gif_path` - the processed lolcommit animated gif path (may be `nil`)
* `runner.capture_video` - `true` when a video capture was generated
* `runner.capture_gif` - `true` when an animated gif capture was generated
* `runner.capture_image` - `true` when an image (jpg) was captured, false for gifs/videos

After the capturing process completes, (i.e. in `run_post_capture` or
`run_capture_ready` hooks) use `runner.lolcommit_path` to access the
lolcommit file (jpg, mp4 or gif).

__NOTE__: it is possible for both an animated gif *AND* video to be
generated, in this case `lolcommits_path` points to the `mp4` video and
`runner.lolcommits_gif_path` points to the animated `gif`.

Take a look at
[Lolcommits::Runner](https://github.com/lolcommits/lolcommits/blob/master/lib/lolcommits/runner.rb)
for more details.

#### Overlay PNG

After capturing (and resizing), the
[runner](https://github.com/lolcommits/lolcommits/blob/master/lib/lolcommits/runner.rb)
provides a blank (transparent) PNG for plugins to manipulate. It
matches the width and height of the lolcommit capture.

To make use of this `runner.overlay`, reference it in any `post_capture`
hook. You can use any `MiniMagick::Image`
[utility](http://rubydoc.info/github/minimagick/minimagick) method. For
example the
[lolcommits-loltext](https://github.com/lolcommits/lolcommits-loltext)
plugin annotates text, a border and overlay colour
[here](https://github.com/lolcommits/lolcommits-loltext/blob/master/lib/lolcommits/plugin/loltext.rb#L74).

After all `post_capture` hooks finish, this overlay PNG is composited on
top of the snapshot and the final lolcommit file is available at
`runner.lolcommit_path` for `capture_ready` hooks to use.

### Testing your plugin

To make test setup easier, the lolcommits gem includes these helpers to
work with command line IO and Git.

    # add one (or both) of these to your plugin's test_helper file
    require 'lolcommits/test_helpers/git_repo'
    require 'lolcommits/test_helpers/fake_io'

    # and include either (or both) modules in your test
    include Lolcommits::TestHelpers::GitRepo
    include Lolcommits::TestHelpers::FakeIO

Use the following methods to manage a test repo:

    setup_repo               # create the test repo
    commit_repo_with_message # perform a git commit in the test repo
    last_commit              # commit info for the last test repo commit
    teardown_repo            # destroy the test repo
    in_repo(&block)          # run lolcommits within the test repo

For STDIN and capturing IO use the `fake_io_capture` method.

    # capture the output of the `configure_options` method, sending the
    # string input 'true' (followed by a carriage return) to STDIN:
    output = fake_io_capture(inputs: %w(true)) do
      configured_plugin_options = plugin.configure_options!
    end

For more examples take a look at the [tests in this
repo](https://github.com/lolcommits/lolcommits-sample_plugin/blob/master/test/lolcommits/plugin/sample_plugin_test.rb).

### General advice

* Use this gem as a starting point, renaming files, classes etc.
* For more examples, take a look at other published [lolcommit
  plugins](https://github.com/lolcommits).
* If you feel something is missing (or out of date) in this guide. Post
  an
  [issue](https://github.com/lolcommits/lolcommits-sample_plugin/issues).

---

## Requirements

* Ruby >= 3.1
* A webcam
* [ImageMagick](http://www.imagemagick.org)
* [ffmpeg](https://www.ffmpeg.org) (optional) for animated gif capturing

## Installation

Follow the [install
guide](https://github.com/lolcommits/lolcommits#installation) for
lolcommits first. Then run the following:

    $ gem install lolcommits-sample_plugin

Next configure and enable this plugin with:

    $ lolcommits --config -p sample_plugin
    # set enabled to `true` and configure other options as you like

That's it! Every lolcommit now comes with it's own emoji themed
commentary!

## Development

Check out this repo and run `bin/setup`, this will install dependencies
and generate docs. Run `bundle exec rake` to run all tests and generate
a coverage report.

You can also run `bin/console` for an interactive prompt that will allow
you to experiment with the gem code.

## Tests

MiniTest is used for testing. Run the test suite with:

    $ rake test

## Docs

Generate docs for this gem with:

    $ rake rdoc

## Troubles?

If you think something is broken or missing, please raise a new
[issue](https://github.com/lolcommits/lolcommits-sample_plugin/issues).
Take a moment to check it hasn't been raised in the past (and possibly
closed).

## Contributing

Bug
[reports](https://github.com/lolcommits/lolcommits-sample_plugin/issues)
and [pull
requests](https://github.com/lolcommits/lolcommits-sample_plugin/pulls)
are welcome on GitHub.

When submitting pull requests, remember to add tests covering any new behaviour,
and ensure all tests are passing on CI. Read the [contributing
guidelines](https://github.com/lolcommits/lolcommits-sample_plugin/blob/master/CONTRIBUTING.md)
for more details.

This project is intended to be a safe, welcoming space for
collaboration, and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.
See
[here](https://github.com/lolcommits/lolcommits-sample_plugin/blob/master/CODE_OF_CONDUCT.md)
for more details.

## License

The gem is available as open source under the terms of
[LGPL-3](https://opensource.org/licenses/LGPL-3.0).

## Links

* [CI](https://github.com/lolcommits/lolcommits-sample_plugin/actions/workflows/build.yml)
* [RDoc](http://rdoc.info/projects/lolcommits/lolcommits-sample_plugin)
* [Issues](http://github.com/lolcommits/lolcommits-sample_plugin/issues)
* [Report a bug](http://github.com/lolcommits/lolcommits-sample_plugin/issues/new)
* [Gem](http://rubygems.org/gems/lolcommits-sample_plugin)
* [GitHub](https://github.com/lolcommits/lolcommits-sample_plugin)
