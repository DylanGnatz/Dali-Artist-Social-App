class Artwork < ApplicationRecord
    belongs_to :profile
    has_one_attached :artImage
  end
  