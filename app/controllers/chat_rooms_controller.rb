class ChatRoomsController < ApplicationController
  def index
  end
  def show
    @chat_room=chat_room.find(params[:chat_room_id])
  end

  private
  def chat_room_params
    @params.require(:chat_room).permit(:user1_id, :user2_id)
end
