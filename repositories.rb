require './models'

require 'mongo'
if mongo_url = ENV['MONGOHQ_URL']
  conn_string = URI.parse(mongo_url)
  db_name = conn_string.path.gsub(/^\//, '')

  DB = Mongo::Connection.new(conn_string.host, conn_string.port).db(db_name)
  DB.authenticate(conn_string.user, conn_string.password) unless (conn_string.user.nil? || conn_string.password.nil?)
else
  DB = Mongo::Connection.new.db("avnsp_album")
end
class Repository
  def self.find(params = {})
    collection.find(params).map { |entity| klass.new(entity) }
  end
  def self.find_one(params)
    entity = collection.find_one(params)
    klass.new(entity) if entity
  end
  def self.save(entity)
    collection.update({_id: entity._id}, entity.to_h)
  end
  def self.insert(entity)
    hash = entity.to_h
    collection.insert(hash)
  end
  def self.collection
    DB.collection(klass.name)
  end
  def self.has symbol, klass
    @@associations << {symbol => klass}
  end
end
class AlbumRepository < Repository
  def self.klass; Album end
end
