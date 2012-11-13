require 'sinatra'

get '/' do
  @albums = AlbumRepository.find()
  haml :index
end
