class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.datetime :last_message

      t.timestamps
    end
  end
end
