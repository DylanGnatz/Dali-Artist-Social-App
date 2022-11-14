class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :profile, null: false, foreign_key: true
      t.string :title
      t.datetime :date
      t.string :location

      t.timestamps
    end
  end
end
