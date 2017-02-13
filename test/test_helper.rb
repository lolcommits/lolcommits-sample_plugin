$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

# necessary libs from lolcommits (allowing plugin to run)
require 'git'
require 'lolcommits/runner'
require 'lolcommits/vcs_info'
require 'lolcommits/backends/git_info'
require 'lolcommits/test_helpers/git_repo'

# plugin gem test libs
require 'lolcommits/sample'
require 'lolcommits/plugin/sample'
require 'minitest/autorun'
require 'helpers/fake_io'

# swallow all debug output during test runs
def debug(msg); end
