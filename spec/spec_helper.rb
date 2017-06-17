require 'factory_girl'
require 'bigdecimal'

require './lib/file_loader'
include FileLoader

require_all('/**/*.rb', '/../models/*.rb')

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end

