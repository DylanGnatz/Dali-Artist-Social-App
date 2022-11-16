class Collective < ApplicationRecord
    has_and_belongs_to_many :profiles, through: :collectives_profiles
    belongs_to :chat
end
