class AddProfileToUserRight < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :profile
  end
end
