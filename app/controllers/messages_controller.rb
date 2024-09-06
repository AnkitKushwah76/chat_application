class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to room_path(params[:room_id])
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(room_id: params[:room_id], user_id: current_user.id)
  end
end
