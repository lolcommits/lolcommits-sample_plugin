require 'test_helper'

describe Lolcommits::Plugin::Sample do

  include Lolcommits::TestHelpers::GitRepo
  include Lolcommits::TestHelpers::FakeIO

  def plugin_name
    'plugin-sample'
  end

  it 'should have a version number' do
    ::Lolcommits::Plugin::Sample::VERSION.wont_be_nil
  end

  it 'should have a name' do
    ::Lolcommits::Plugin::Sample.name.must_equal plugin_name
  end

  it 'should run on post capturing' do
    ::Lolcommits::Plugin::Sample.runner_order.must_equal [:precapture, :postcapture]
  end

  describe 'with a runner' do
    def runner
      # a simple lolcommits runner with an empty configuration Hash
      @runner ||= Lolcommits::Runner.new(
        config: OpenStruct.new(read_configuration: {})
      )
    end

    def plugin
      @plugin ||= Lolcommits::Plugin::Sample.new(runner)
    end

    def valid_enabled_config
      @config ||= OpenStruct.new(
        read_configuration: {
          plugin.class.name => { 'enabled' => true }
        }
      )
    end

    describe 'initalizing' do
      it 'should assign runner and an enabled option' do
        plugin.runner.must_equal runner
        plugin.options.must_equal ['enabled']
      end
    end

    describe '#run_precapture' do

      before { commit_repo_with_message }

      it 'should output a message to stdout' do
        in_repo do
          Proc.new { plugin.run_precapture }.
            must_output "✨  Say cheese 😁 !\n"
        end
      end

      after { teardown_repo }
    end

    describe '#run_postcapture' do

      before { commit_repo_with_message }

      it 'should output a message to stdout' do
        in_repo do
          Proc.new { plugin.run_postcapture }.
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
        plugin.runner.config = valid_enabled_config
        plugin.enabled?.must_equal true
      end
    end

    describe 'configuration' do
      it 'should not be configured by default' do
        plugin.configured?.must_equal false
      end

      it 'should allow plugin options to be configured' do
        configured_plugin_options = {}

        output = fake_io_capture(inputs: %w(true)) do
          configured_plugin_options = plugin.configure_options!
        end

        configured_plugin_options.must_equal( { "enabled" => true })
      end

      it 'should indicate when configured' do
        plugin.runner.config = valid_enabled_config
        plugin.configured?.must_equal true
      end

      describe '#valid_configuration?' do
        it 'should be false without config set' do
          plugin.valid_configuration?.must_equal(false)
        end

        it 'should be true for a valid configuration' do
          plugin.runner.config = valid_enabled_config
          plugin.valid_configuration?.must_equal true
        end
      end
    end
  end
end
