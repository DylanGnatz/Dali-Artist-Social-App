class AddBioToCollectives < ActiveRecord::Migration[7.0]
  def change
    add_column :collectives, :bio, :text
  end
end
