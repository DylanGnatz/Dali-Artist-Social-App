class CreateCollectiveArtworks < ActiveRecord::Migration[7.0]
  def change
    create_table :collective_artworks do |t|
      t.references :collective, null: false, foreign_key: true
      t.string :type
      t.string :title
      t.string :description
      t.boolean :onCollective
      t.boolean :isPrivate
      t.string :link

      t.timestamps
    end
  end
end
