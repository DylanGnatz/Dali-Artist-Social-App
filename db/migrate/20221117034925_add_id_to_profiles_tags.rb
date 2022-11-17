class AddIdToProfilesTags < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles_tags, :id, :primary_key
  end
end
