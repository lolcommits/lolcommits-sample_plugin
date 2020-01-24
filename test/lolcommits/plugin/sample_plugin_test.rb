# frozen_string_literal: true

require 'test_helper'

describe Lolcommits::Plugin::SamplePlugin do

  include Lolcommits::TestHelpers::GitRepo
  include Lolcommits::TestHelpers::FakeIO

  describe 'with a runner' do
    def runner
      # a simple lolcommits runner with an empty configuration Hash
      @runner ||= Lolcommits::Runner.new(
        lolcommit_path: "/path/to/lolcommit.jpg"
      )
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

      it 'outputs a message to stdout' do
        in_repo do
          _(Proc.new { plugin.run_pre_capture }).
            must_output "✨  Say cheese 😁 !\n"
        end
      end

      after { teardown_repo }
    end

    describe '#run_post_capture' do
      before { commit_repo_with_message }

      it 'outputs a message to stdout' do
        plugin.configuration = valid_enabled_config
        in_repo do
          _(Proc.new { plugin.run_post_capture }).
            must_output "📸  📸  📸  📸  📸  Snap!\n"
        end
      end

      after { teardown_repo }
    end

    describe '#run_capture_ready' do

      before { commit_repo_with_message }

      it 'outputs a message to stdout' do
        in_repo do
          _(Proc.new { plugin.run_capture_ready }).
            must_output "wow! #{last_commit.sha[0..10]} at /path/to/lolcommit.jpg is your best looking commit yet!\n(it was an image!)\n"
        end
      end

      after { teardown_repo }
    end

    describe '#enabled?' do
      it 'returns be false by default' do
        _(plugin.enabled?).must_equal false
      end

      it 'returns true when configured' do
        plugin.configuration = valid_enabled_config
        _(plugin.enabled?).must_equal true
      end
    end

    describe 'configuration' do
      it 'allows plugin options to be configured' do
        configured_plugin_options = {}

        fake_io_capture(inputs: %w(true false true true 5)) do
          configured_plugin_options = plugin.configure_options!
        end

        _(configured_plugin_options).must_equal(valid_enabled_config)
      end

      describe '#valid_configuration?' do
        it 'returns false without config set' do
          _(plugin.valid_configuration?).must_equal(false)
        end

        it 'returns true for a valid configuration' do
          plugin.configuration = valid_enabled_config
          _(plugin.valid_configuration?).must_equal true
        end
      end
    end
  end
end
