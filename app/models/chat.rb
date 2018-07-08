class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  after_create :create_notify_pusher, on: :create
  def create_notify_pusher
    Pusher.trigger('chat', 'new', self.as_json)
  end
end
