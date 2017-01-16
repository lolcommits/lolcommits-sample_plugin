$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'lolcommits'
require 'lolcommits/sample'
require 'lolcommits/plugin/sample'
require 'minitest/autorun'
require 'helpers/fake_io'

# global helper methods required for tests
def debug(msg); end
