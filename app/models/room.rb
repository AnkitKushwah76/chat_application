class Room < ApplicationRecord
  serialize :user_ids, JSON
  has_many :messages

  validates_uniqueness_of :name

  after_create_commit {broadcast_append_to "rooms"}

  private

  def self.get_current_user_room(user)
    Room.where("user_ids LIKE ?", "%#{user.id}%")
  end

  def self.get_all_users(current_user, room_id)

    all_users = User.where.not(id: current_user.id)
    room = Room.find_by(id: room_id)
    all_users.where.not(id: room&.user_ids)
  end
end