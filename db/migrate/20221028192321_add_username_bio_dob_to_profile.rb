class AddUsernameBioDobToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :username, :string, null: false, limit: 100
    add_column :profiles, :bio, :string, limit: 2000
    add_column :profiles, :date_of_birth, :date
  end
end
