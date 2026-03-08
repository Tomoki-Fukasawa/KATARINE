class ChatRoomsController < ApplicationController
  def index
    @chat_room=ChatRoom.find(params[:id])
    @chat_rooms=ChatRoom.where(user1_id: current_user.id).or(ChatRoom.where(user2_id: current_user.id))
    @partner = @chat_room.partner(current_user)
  end

  def show
    @chat_room=ChatRoom.find(params[:id])
    # if (current_user==@chat_room.user1) || (current_user==@chat_room.user2)
    #   @messages=@chat_room.messages
    #   @partner = @chat_room.partner(current_user)
    # else
    #   redirect_to root_path
    # end

    unless current_user.friends_with?(@chat_room.partner(current_user))
      redirect_to root_path
      return
    end
    @message=@chat_room.messages.new(message_params)
    @messages=@chat_room.messages
    @partner = @chat_room.partner(current_user)
  end

  # private

  # def chat_room_params
  #   params.require(:chat_room).permit(:user1_id, :user2_id)
  # end
end