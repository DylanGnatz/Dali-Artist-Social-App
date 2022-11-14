class Event < ApplicationRecord
  belongs_to :profile
  validates :title, length: { in: 1..200 }
end
