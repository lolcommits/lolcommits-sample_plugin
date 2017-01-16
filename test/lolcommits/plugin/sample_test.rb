require 'test_helper'

describe Lolcommits::Plugin::Sample do

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
    ::Lolcommits::Plugin::Sample.runner_order.must_equal :postcapture
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
      it 'should assign runner and default enabled option' do
        plugin.runner.must_equal runner
        plugin.options.must_equal ['enabled']
      end
    end

    describe '#run_postcapture' do
      it 'should output a message to stdout' do
        Proc.new { plugin.run_postcapture }.must_output
          "✨  wow! #{runner.sha} is your best looking commit yet! 😘  💻\n"
      end
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

        output = FakeIO.capture(inputs: %w(true)) do
          configured_plugin_options = plugin.configure_options!
        end

        configured_plugin_options.must_equal( { "enabled" => true })
      end

      it 'should indicate when configured' do
        plugin.runner.config = valid_enabled_config
        plugin.configured?.must_equal true
      end

      describe '#valid_configuration?' do
        it 'should be false and show help for an empty configuration' do
          Proc.new { plugin.valid_configuration?.must_equal(false) }.
            must_output "Missing #{plugin_name} config - configure with: lolcommits --config -p #{plugin_name}\n"
        end

        it 'should be true for a valid configuration' do
          plugin.runner.config = valid_enabled_config
          plugin.valid_configuration?.must_equal true
        end
      end
    end
  end
end

