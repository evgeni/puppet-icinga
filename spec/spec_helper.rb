dir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift File.join(dir, 'lib')
fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

#require 'mocha'
require 'puppet'
require 'rspec-puppet'
require 'rspec/autorun'

RSpec.configure do |config|
#    config.mock_with :mocha
    config.module_path = File.join(fixture_path, 'modules')
    config.manifest_dir = File.join(fixture_path, 'manifests')
end
