class CreateUsersChatRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :users_chat_rooms do |t|
      t.references                    :user
      t.references                    :chat_room

      t.integer                       :status, default: 0
      # 0: 참가중, 1: 준비중, 2: 나감, 3: 시작함, 4: 끝남

      t.timestamps
    end
  end
end
