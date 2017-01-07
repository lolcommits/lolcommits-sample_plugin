require 'lolcommits/plugin/base'

module Lolcommits
  module Plugin
    class Sample < Base

      # include the gem VERSION constant
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

      # this is the method we would use if we were defined as :precapture
      def run_precapture
      end

      def run_postcapture
        puts "✨ wow! #{self.runner.sha} is your best looking commit yet! 😘💻"
      end

      # TODO add guidance for these optional method overrides
      #
      # def initialize(runner)
      #   super
      #   # anything else you need to do at initialization
      # end
      #
      # def enabled?
      #   super
      # end
      #
      # def configure_options!
      #   super
      # end
      #
      # def valid_configuration?
      #   super
      # end
      #
      # def configured?
      # end
    end
  end
end
