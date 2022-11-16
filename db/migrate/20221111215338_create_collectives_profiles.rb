class CreateCollectivesProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :collectives_profiles do |t|
      t.references :collective, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
