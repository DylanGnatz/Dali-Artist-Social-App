class FixReferenceUserProfile < ActiveRecord::Migration[7.0]
  def change
    remove_reference :users, :profile
    add_reference :profiles, :user
  end
end
