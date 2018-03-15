require 'lolcommits/plugin/base'

module Lolcommits
  module Plugin
    class SamplePlugin < Base

      ##
      # Initializer
      #
      # @param runner [Lolcommits::Runner] an instance of a Lolcommits runner
      # @param name [String] name for this plugin, usually set from Gem name
      # @param config [Hash] plugin config hash (parsed from saved config YAML)
      #
      # The default superclass method sets @runner and @configuration instance
      # vars and @options to `[:enabled]`
      #
      # Override this method to change the default configurable option names
      #
      def initialize(runner: nil, name: nil, config: nil)
        super
      end

      ##
      # Pre-capture hook, runs before lolcommits captures a snapshot.
      #
      # Override this method to execute plugin code before the lolcommit
      # snapshot is captured.
      #
      # Prints a short (emoji themed) message to STDOUT
      #
      def run_pre_capture
        puts "✨  Say cheese 😁 !" if config_option(:ask_for_cheese)
      end

      ##
      # Post-capture hook, run after lolcommits captures a snapshot.
      #
      # Override this method to execute plugin code after the lolcommit snapshot
      # is captured.
      #
      # Prints a short (emoji themed) message to STDOUT
      #
      def run_post_capture
        return unless config_option(:camera_emoji, :enabled)
        puts "#{"📸  " * config_option(:camera_emoji, :emoji_multiplier).to_i}Snap!"
      end

      ##
      # Capture ready hook, runs after lolcommits captures a snapshot.
      #
      # Override this method to execute plugin code after the lolcommit snapshot
      # is captured and all image processing in post capture hooks (from other
      # plugins) has completed
      #
      # Prints a short (emoji themed) message to STDOUT with the current commit
      # sha.
      #
      def run_capture_ready
        if config_option(:always_a_great_commit?)
          puts "✨  wow! #{self.runner.sha} is your best looking commit yet! 😘  💻"
        end
      end

      ##
      # Returns true/false indicating if the plugin is enabled or not.
      #
      # The default superclass method returns true if the enabled option is true
      # i.e. configuration[:enabled] == true
      #
      # Override this method to define your own custom enabled logic. If this
      # method always returns true, the only way to disable the plugin will be
      # to uninstall the gem.
      #
      # Note: a `valid_configuration?` method also exists and is checked before
      # any plugin hooks execute. Use that to check individual config option
      # values are valid.
      #
      # @return [Boolean] true/false indicating if plugin is enabled
      #
      def enabled?
        super
      end

      ##
      # Prompts the user to configure all plugin options.
      #
      # Available options can be defined in an Array (@options instance var)
      # and/or a Hash (by overriding the `default_options` method).
      #
      # By default (on initialize), `@options` is set with `[:enabled]`. This is
      # mandatory since `enabled?` checks this option is true before running any
      # capture hooks.
      #
      # Using a Hash to define default options allows you to:
      #
      #  - fall back to default values
      #  - define nested options, user is prompted for each nested option key
      #
      # `configure_option_hash` will iterate over all options prompting the user
      # for input and building the configuration Hash.
      #
      # Lolcommits will save this Hash to a YAML file. During the capture
      # process the configuration is loaded, parsed and available in the plugin
      # class as `@configuration`. Or if you want to fall back to default
      # values, you should use `config_option` to dig the hash.
      #
      # Alternatively you can override this method entirely to customise the
      # process. A helpful `parse_user_input` method is available to help parse
      # strings from STDIN (into boolean, integer or nil values).
      #
      # @return [Hash] the configured plugin options
      #
      def configure_options!
        super
      end

      ##
      # Returns a hash of default options to be presented to the user when
      # configuring (with `configure_options!`.
      #
      # @return [Hash] with the default option names (keys) and values
      #
      def default_options
        {
          ask_for_cheese: true,
          always_a_great_commit?: true,
          camera_emoji: {
            enabled: false,
            emoji_multiplier: 2
          }
        }
      end

      ##
      # Returns true/false indicating if the plugin has been correctly
      # configured.
      #
      # The default superclass method simply checks if `@configuration` is
      # present (not empty).
      #
      # By default if this method returns false, plugin hooks will not execute
      # and a warning message is shown prompting the user to re-configure the
      # plugin.
      #
      # Override to define your own configuration checks and/or messaging.
      #
      # @return [Boolean] true/false indicating if plugin is correct configured
      #
      def valid_configuration?
        super
      end
    end
  end
end
