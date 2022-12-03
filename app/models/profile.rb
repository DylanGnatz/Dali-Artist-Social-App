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
      #Do not show profiles already swiped on
      already_swiped_prof = Swipe.where(profile_id: self.id).pluck(:swiped_id)
      #Do not show own profile
      already_swiped_prof.push(self.id)
      if self.search_setting.tag_restrict
        #prof = Profile.near([self.lat, self.lng], self.search_setting.search_radius).where(tags: self.tags).where.not(id: already_swiped_prof).order("RANDOM()").first
        prof = Profile.near([self.lat, self.lng], self.search_setting.search_radius).where.not(id: already_swiped_prof).order("RANDOM()").first
      else
        prof = Profile.near([self.lat, self.lng], self.search_setting.search_radius).where.not(id: already_swiped_prof).order("RANDOM()").first
      end
      unless prof.nil?
        queue.push(prof)
      end
    end

    if self.search_setting.show_events
      #Do not show events already swiped on
      already_swiped_event = Swipe.where(profile_id: self.id).pluck(:event_id)
      #Do not show events owned by the user
      already_swiped_event.push(Event.where(profile_id:self.id).pluck(:id))

      event = Event.where.not(id: already_swiped_event).order("RANDOM()").first
      unless event.nil?
        queue.push(event)
      end
    end

    if self.search_setting.show_collectives
      #Do not show collectives that were already swiped on
      already_swiped_collective = Swipe.where(profile_id: self.id).pluck(:collective_id)
      #Do not show collectives that user is already a part of
      already_swiped_collective.push(self.collectives.pluck(:collective_id))

      collective = Collective.where.not(id: already_swiped_collective).order("RANDOM()").first
      unless collective.nil?
        queue.push(collective)
      end
    end
    return queue.sample
  end

end
