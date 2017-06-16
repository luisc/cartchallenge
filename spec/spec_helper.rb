require 'factory_girl'
require './lib/file_loader'
include FileLoader
require_all('**/*.rb', '/../models/*.rb')

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

