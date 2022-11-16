class AddChatToCollective < ActiveRecord::Migration[7.0]
  def change
    add_reference :collectives, :chat, null: false, foreign_key: true
  end
end
