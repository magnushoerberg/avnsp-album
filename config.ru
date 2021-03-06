require 'bundler/setup'
require './repositories'
require './app'

map '/' do
  use Rack::Session::Cookie, {
    secret: ENV['SESSION_SECRET'] || '12h12u8JKBVss84',
    httponly: true, 
    secure: (ENV['RACK_ENV'] == 'production'),
    :cache_control => "public,max-age=#{5}"
  }
  run Sinatra::Application
end
