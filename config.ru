require 'bundler/setup'
require './repositories'
require './app'

run Sinatra::Application
