class Artwork < ApplicationRecord
    belongs_to :profile
    has_one_attached :art_image
  end
  