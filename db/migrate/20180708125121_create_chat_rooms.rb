class CreateChatRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_rooms do |t|
      t.references              :user
      t.string                  :title
      t.timestamps
    end
  end
end
