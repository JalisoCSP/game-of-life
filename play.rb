require File.expand_path('game_of_life', File.dirname(__FILE__))
require File.expand_path('pattern', File.dirname(__FILE__))

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'colorize'
end

arg = ARGV[0]
pattern = Pattern.const_get (arg || "john").upcase.to_sym
GameOfLife.new(array: pattern).call
