class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :tag_name
      t.timestamps
    end
    create_table :profiles_tags do |t|
      t.belongs_to :profile
      t.belongs_to :tag
      t.timestamps
    end
  end
end
