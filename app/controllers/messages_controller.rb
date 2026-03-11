class MessagesController < ApplicationController
  def create
    @chat_room=ChatRoom.find(params[:chat_room_id])

    unless [@chat_room.user1_id, @chat_room.user2_id].include?(current_user.id)
      redirect_to root_path
      return
    end
    @message=@chat_room.messages.new(message_params)
    # @message.chat_room = @chat_room
    @message.user= current_user

    if @message.save
      redirect_to chat_room_path(@chat_room)
    else
      @messages = @chat_room.messages.includes(:user)
      @message=@chat_room.messages.new
      @partner=@chat_room.partner(current_user)
      render "chat_rooms/show", status: :unprocessable_entity
    end
  end

  private
  def message_params
    params.require(:message).permit(:content, :image)
  end
end
