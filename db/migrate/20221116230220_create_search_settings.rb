class CreateSearchSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :search_settings do |t|
      t.belongs_to :profile
      t.int :search_radius
      t.boolean :gender_restrict
      t.boolean :tag_restrict
      t.boolean :show_events
      t.boolean :show_profiles
      t.boolean :show_collectives
    end
  end
end
