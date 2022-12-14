class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile
  has_many :swipe
  has_many :match
  before_create do
    self.build_profile(username: self.username)
  end
  accepts_nested_attributes_for :profile
  validates :username, length: { in: 2..80 }
end
