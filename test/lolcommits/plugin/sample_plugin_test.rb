require 'test_helper'

describe Lolcommits::Plugin::SamplePlugin do

  include Lolcommits::TestHelpers::GitRepo
  include Lolcommits::TestHelpers::FakeIO

  it 'should run on pre_capture and capture_ready' do
    ::Lolcommits::Plugin::SamplePlugin.runner_order.must_equal [
      :pre_capture, :post_capture, :capture_ready
    ]
  end

  describe 'with a runner' do
    def runner
      # a simple lolcommits runner with an empty configuration Hash
      @runner ||= Lolcommits::Runner.new
    end

    def plugin
      @plugin ||= Lolcommits::Plugin::SamplePlugin.new(runner: runner)
    end

    def valid_enabled_config
      {
        enabled: true,
        ask_for_cheese: false,
        always_a_great_commit?: true,
        camera_emoji: {
          enabled: true,
          emoji_multiplier: 5
        }
      }
    end

    describe '#run_pre_capture' do
      before { commit_repo_with_message }

      it 'should output a message to stdout' do
        in_repo do
          Proc.new { plugin.run_pre_capture }.
            must_output "✨  Say cheese 😁 !\n"
        end
      end

      after { teardown_repo }
    end

    describe '#run_capture_ready' do

      before { commit_repo_with_message }

      it 'should output a message to stdout' do
        in_repo do
          Proc.new { plugin.run_capture_ready }.
            must_output "✨  wow! #{last_commit.sha[0..10]} is your best looking commit yet! 😘  💻\n"
        end
      end

      after { teardown_repo }
    end

    describe '#enabled?' do
      it 'should be false by default' do
        plugin.enabled?.must_equal false
      end

      it 'should true when configured' do
        plugin.configuration = valid_enabled_config
        plugin.enabled?.must_equal true
      end
    end

    describe 'configuration' do
      it 'should allow plugin options to be configured' do
        configured_plugin_options = {}

        fake_io_capture(inputs: %w(true false true true 5)) do
          configured_plugin_options = plugin.configure_options!
        end

        configured_plugin_options.must_equal(valid_enabled_config)
      end

      describe '#valid_configuration?' do
        it 'should be false without config set' do
          plugin.valid_configuration?.must_equal(false)
        end

        it 'should be true for a valid configuration' do
          plugin.configuration = valid_enabled_config
          plugin.valid_configuration?.must_equal true
        end
      end
    end
  end
end
