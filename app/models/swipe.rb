class Swipe < ApplicationRecord
  belongs_to :profile

  def self.match(swiper_id, swiped_id)

    swipe_1 = Swipe.find_by(profile_id: swiper_id, swiped_id: swiped_id)
    swipe_2 = Swipe.find_by(profile_id: swiped_id, swiped_id: swiper_id)
    if swipe_1 and swipe_2

      if swipe_1.interested and swipe_2.interested
        Friend.create(profile_id: swiper_id,friend_id: swiped_id)
        return true
      end
    end
    return false
  end
end
