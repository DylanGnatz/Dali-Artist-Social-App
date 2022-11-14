class ProfileTag < ApplicationRecord
  belongs_to :profile, :tag
end