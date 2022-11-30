class CollectiveArtwork < ApplicationRecord
  belongs_to :collective
  has_one_attached :art_image
end
