class CreateChatsProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :chats_profiles do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :chat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
