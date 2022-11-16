class Profile < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :chats, through: :chats_profiles
  has_many :friends
  has_many :artworks
  has_many :events
  has_many :profile_tags
  has_one_attached :profile_photo

  reverse_geocoded_by :lat, :lng
  has_and_belongs_to_many :collectives, through: :collectives_profiles

  def all_friends
    all = []
    Profile.find(id).friends.each do |obj|
      all.push(Profile.find(obj.friend_id))
    end
    Friend.where("friend_id = ?", id).each do |frndObj|
      all.push(frndObj.profile)
    end
    all
  end

  def get_geocoder_data
    lat = "latitude"
    lon = "longitude"
    lat_lng = "#{self.lat},#{self.lng}"
    response = Geocoder.search(lat_lng).first
    return response
  end

end
