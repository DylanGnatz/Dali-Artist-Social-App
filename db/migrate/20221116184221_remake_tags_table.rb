class RemakeTagsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

    create_table :profiles_tags, id: false do |t|
      t.bigint :profile_id
      t.bigint :tag_id
    end

    add_index :profiles_tags, :profile_id
    add_index :profiles_tags, :tag_id
  end
end
