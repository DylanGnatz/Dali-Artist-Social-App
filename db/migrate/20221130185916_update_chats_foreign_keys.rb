class UpdateChatsForeignKeys < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :chats_messages, :chats
    remove_foreign_key :chats_profiles, :chats
    remove_foreign_key :collectives_profiles, :collectives

    add_foreign_key :chats_messages, :chats, on_delete: :cascade
    add_foreign_key :chats_profiles, :chats, on_delete: :cascade
    add_foreign_key :collectives_profiles, :collectives, on_delete: :cascade

  end
end
