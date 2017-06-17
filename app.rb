#!/usr/bin/env ruby

require 'bigdecimal'
require './lib/file_loader'
include FileLoader
require_all('/../models/*.rb')

# # specify globs of files to include
# globs = [
#   '/models/*.rb',
#   '/lib/*.rb'
# ]

# require each of those files
# selectors.each do |selector|
#   Dir[File.dirname(__FILE__) + selector].each {|file| require file }
# end

puts Order.new