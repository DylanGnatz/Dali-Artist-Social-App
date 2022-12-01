class Collective < ApplicationRecord
    has_and_belongs_to_many :profiles, through: :collectives_profiles
    belongs_to :chat
    has_many :collective_artworks
    has_one_attached :main_photo
end
