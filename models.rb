require './hashable'

AlbumValues = Struct.new(:date, :created, :name,
                         :creator, :festivity, :images)
class Album < AlbumValues
  include Hashable
  def initialize(params)
    params = params.map { |k, v| {k.to_sym => v} }.inject(&:merge)
    params[:creator] = Creator.new(params[:creator])
    params[:festivity] = Festivity.new(params[:festivity])
    super(params[:date],
          params[:created],
          params[:name],
          params[:creator],
          params[:festivity],
          params[:images])
  end

  def thumb_url
    image = self.images.first
    image ? image.thumb_url : 'https://placehold.it/260x180'
  end
  def description
    self.name || self.festivity.name
  end
end

CreatorValues = Struct.new(:name, :uuid)
class Creator < CreatorValues
  include Hashable
  def initialize(params)
    params = params.map { |k, v| {k.to_sym => v} }.inject(&:merge)
    super(params[:name], params[:uuid])
  end
  def href
    "https://avnsp-sso.herokuapp.com/user/#{self.uuid}"
  end
end
FestivityValues = Struct.new(:name, :uuid)
class Festivity < FestivityValues
  include Hashable
  def initialize(params)
    params = params.map { |k, v| {k.to_sym => v} }.inject(&:merge)
    super(params[:name],
          params[:uuid])
  end
  def href
    "https://avnsp-fest.herokuapp.com/fest/#{self.uuid}"
  end
end
