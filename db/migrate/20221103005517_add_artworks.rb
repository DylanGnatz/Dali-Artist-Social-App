class AddArtworks < ActiveRecord::Migration[7.0]
  def change
    create_table :artwork do |t|
      t.references :profile, null: false, foreign_key: true
      t.boolean :onPortfolio
      t.datetime :addedDate, null: false
      t.string :type, limit: 100
      t.string :title, limit: 100
      t.string :link, limit: 100
      t.string :description, limit: 2000
      t.boolean :isPrivate
    end
  end
end
