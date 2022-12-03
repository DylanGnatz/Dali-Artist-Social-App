class Profile < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :chats, through: :chats_profiles
  has_many :friends
  has_many :artworks
  has_many :events
  has_one :search_setting
  has_and_belongs_to_many :tags
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

  def match_queue
    queue = []
    if self.search_setting.show_profiles
      already_swiped = Swipe.where(profile_id: self.id).pluck(:swiped_id)
      already_swiped.push(self.id)
      prof = Profile.near([self.lat, self.lng], self.search_setting.search_radius).where.not(id: already_swiped).order("RANDOM()").first
      unless prof.nil?
        queue.push(prof)
      end
    end
    if self.search_setting.show_events
      queue.push(Event.order("RANDOM()").first)
    end
    if self.search_setting.show_collectives
      queue.push(Collective.order("RANDOM()").first)
    end
    return queue.sample
  end

end
