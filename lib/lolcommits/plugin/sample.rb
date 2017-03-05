require 'lolcommits/plugin/base'

module Lolcommits
  module Plugin
    class Sample < Base

      # include the gem version constant
      include Lolcommits::Sample

      ##
      # Returns the name of the plugin.
      #
      # Identifies the plugin to lolcommits. This should be uniq and
      # descriptive.
      #
      # @return [String] the plugin name
      #
      def self.name
        'plugin-sample'
      end

      ## Returns the order this plugin should run at during the capture process.
      #
      # Defines when your plugin will initalized and executed. This must be
      # defined, if the method returns nil the plugin will never run.
      #
      # @return [Symbol] the order position (:precapture or :postcapture)
      #
      def self.runner_order
        :postcapture
      end

      ##
      # Plugin initializer
      #
      # @param runner [Lolcommits::Runner] a instance of a lolcommits runner
      #
      # The default superclass method sets the @runner instance var and default
      # plugin option keys e.g. @options = ['enabled']
      #
      # Override this method to change the default options, or assign any useful
      # variables necessary for the plugin to run.
      #
      def initialize(runner)
        super
      end

      ##
      # Pre-capture hook, runs before lolcommits captures a snapshot.
      #
      # Override this method to execute plugin code before the lolcommit
      # snapshot is captured.
      #
      def run_precapture
      end

      ##
      #
      # Post-capture hook, runs after lolcommits captures a snapshot.
      #
      # Override this method to execute plugin code after the lolcommit snapshot
      # is captured.
      #
      # Prints a short (emoji themed) message to STDOUT with the current commit
      # sha.
      #
      def run_postcapture
        puts "✨  wow! #{self.runner.sha} is your best looking commit yet! 😘  💻"
      end

      ##
      # Returns true/false indicating if the plugin is enabled or not.
      #
      # The default superclass method will return true if the enabled option is
      # true  e.g. configuration['enabled'] == true
      #
      # Override this method to define your own custom enabled logic. E.g. check
      # for valid or required configuration options to be set. If this method
      # always returns true, the only way to disable the plugin will be to
      # uninstall the gem.
      #
      # @return [Boolean] true/false indicating if plugin is enabled
      #
      def enabled?
        super
      end

      ##
      # Prompts the user to configure the plugin's options.
      #
      # The default superclass method will iterate over the @options array and
      # build a configuration hash, prompting for user input on each option key.
      #
      # Lolcommits will save this configuration hash to its default config file
      # (YAML). This config Hash is loaded and parsed during the capturing
      # process and available in this plugin class via the configuration method.
      #
      # Override this method to define your own configuration flow. A helpful
      # parse_user_input method is available to help parse strings from STDIN.
      #
      # @return [Hash] a hash of configured plugin options
      #
      def configure_options!
        super
      end

      ##
      # Returns true/false indicating if the plugin has been correctly
      # configured.
      #
      # The default superclass method calls configured?. When false a message is
      # shown explaining the plugin has not yet been configured, with help on
      # how to configure it.
      #
      # Override this method to define your own configuration checks and
      # messaging.
      #
      # It is good practice to call this method (and return early) in any pre or
      # post capture hooks.
      #
      # @return [Boolean] true/false indicating if plugin is correct configured
      #
      def valid_configuration?
        super
      end

      ##
      # Returns true/false indicating if the plugin has been configured.
      #
      # The default superclass method checks if the configuration hash is empty.
      # Override this method to define your own check on whether configuration
      # has taken place.
      #
      # @return [Boolean] true/false indicating if plugin has been configured
      #
      def configured?
        super
      end
    end
  end
end
