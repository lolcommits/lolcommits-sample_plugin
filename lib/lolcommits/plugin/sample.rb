require 'lolcommits/plugin/base'

module Lolcommits
  module Plugin
    class Sample < Base

      # always include the gem VERSION constant
      include Lolcommits::Sample

      # TODO explain runner and options attributes, their classes and useful
      # methods

      # the name of your plugin please be uniq and related to the gem name
      def self.name
        'plugin-sample'
      end

      # required, defines when your plugin will initalized and executed
      # valid options are [:precapture, :postcapture]
      # if not defined or nil, plugin will never run
      def self.runner_order
        :postcapture
      end

      # this is the method we override for a :precapture action
      def run_precapture
      end

      # this is the method we override for a :postcapture action
      def run_postcapture
        puts "✨  wow! #{self.runner.sha} is your best looking commit yet! 😘  💻"
      end

      # TODO add guidance for these optional method overrides
      def initialize(runner)
        super
      end

      def enabled?
        super
      end

      def configure_options!
        super
      end

      def valid_configuration?
        super
      end

      def configured?
        super
      end
    end
  end
end
