class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.tag_name
      t.timestamps
    end
    create_table :profile_tags do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :tags, null: false, foreign_key: true
      t.timestamps
    end
  end
end
