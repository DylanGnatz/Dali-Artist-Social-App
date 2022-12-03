class RemakeSwipesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :swipes
    create_table :swipes do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :event, foreign_key: true
      t.references :collective, foreign_key: true
      t.integer :swiped_id, null: false
      t.boolean :interested, null: false
      t.datetime :swipe_time, null: false
    end
  end
end
