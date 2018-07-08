class UsersChatRoom < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room
  after_commit :join_notify_pusher, on: :create
  # after_commit :exit_notify_pusher, on: :destroy

  def join_notify_pusher
    Pusher.trigger('join', 'create', self.user.email.as_json)
  end

  # def exit_notify_pusher
  #   Pusher.trigger('join', 'destroy', self.as_json)
  # end
end
