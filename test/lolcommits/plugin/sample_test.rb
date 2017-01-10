require 'test_helper'

describe Lolcommits::Plugin::Sample do

  it 'should have a version number' do
    ::Lolcommits::Plugin::Sample::VERSION.wont_be_nil
  end

  it 'should have a name' do
    ::Lolcommits::Plugin::Sample.name.must_equal 'plugin-sample'
  end

  describe 'with a runner' do
    def plugin
      @plugin ||= Lolcommits::Plugin::Sample.new(OpenStruct.new)
    end

    describe 'capturing' do
      it 'should execute on post capture' do
      end

      it 'should puts a message after capturing' do
      end
    end

    describe 'enabled' do
      it 'should be disabled by default' do
      end
    end

    describe 'configuring' do
      it 'should not be configured by default' do
      end

      it 'should check for a valid configuration' do
      end

      it 'should allow options to be configured' do
      end
    end
  end
end
