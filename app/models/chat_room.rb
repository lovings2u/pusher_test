class ChatRoom < ApplicationRecord
  has_many :users_chat_rooms
  has_many :users, through: :users_chat_rooms
  has_many :chats

  after_commit :create_notify_pusher, on: :create
  after_commit :destroy_notify_pusher, on: :destroy
  after_commit :update_notify_pusher, on: :update

  def set_master_of_room(user)
    UsersChatRoom.create(user_id: user.id, chat_room_id: self.id)
  end

  def user_joined_room(user)
    UsersChatRoom.create(user_id: user.id, chat_room_id: self.id)
  end

  def create_notify_pusher
    Pusher.trigger('chat_room', 'create', self.as_json)
  end

  def destroy_notify_pusher
    Pusher.trigger('chat_room', 'destroy', self.as_json)
  end

  def update_notify_pusher
    Pusher.trigger('chat_room', 'update', self.as_json)
  end
end
