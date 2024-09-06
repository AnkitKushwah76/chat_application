class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_room

  def index
  end

  def show
    @current_user = current_user
    @single_room = Room.find(params[:id])
    @message = Message.new
    @messages = @single_room.messages

    render "index"
  end

  def create
    @room = Room.create!(name: params["room"]["name"], user_ids: [current_user.id])
    redirect_to rooms_path
  end


  def add_people
    room = Room.find(params['id'])
    if room
      room.user_ids << params['user_id'].to_i
      room.save!
      message = "People has been successfully added to the channel."
    end

    flash[:notice] = message
    redirect_to room_path(room)
  end


  private

  def get_room  
    @all_users = Room.get_all_users(current_user, params['id'])
    @rooms = Room.get_current_user_room(current_user)
    @room = Room.new
  end
end
