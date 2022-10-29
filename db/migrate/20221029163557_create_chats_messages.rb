class CreateChatsMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :chats_messages do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :chat, null: false, foreign_key: true
      t.string :msg

      t.timestamps
    end
  end
end
