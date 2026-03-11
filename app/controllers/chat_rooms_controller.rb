class ChatRoomsController < ApplicationController

  def index
    # @chat_room=ChatRoom.new
    @chat_rooms=ChatRoom.where(user1_id: current_user.id).or(ChatRoom.where(user2_id: current_user.id))
    # @partner = @chat_room.partner(current_user)
  end

  def show
    @chat_room = ChatRoom.where(user1_id: current_user.id)
                     .or(ChatRoom.where(user2_id: current_user.id))
                     .find(params[:id])

    if (current_user==@chat_room.user1) || (current_user==@chat_room.user2)
      @message=@chat_room.messages.new
      @messages=@chat_room.messages.includes(:user)
      @partner = @chat_room.partner(current_user)
      unless current_user.friends_with?(@chat_room.partner(current_user))
          redirect_to chat_rooms_path
        return
      end
    else
      redirect_to chat_rooms_path
    end
  end

  # private

  # def chat_room_params
  #   params.require(:chat_room).permit(:user1_id, :user2_id)
  # end

  
end