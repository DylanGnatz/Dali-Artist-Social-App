class AddProfileToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :procedure, index: true
  end
end
