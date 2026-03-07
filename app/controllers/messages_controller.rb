class MessagesController < ApplicationController
  def create
    @chat_room=ChatRoom.find(params[:chat_room_id])
    @message=@chat_room.messages.new(message_params)
    if @message.save
      redirect_to chat_room_path(@chat_room)
    else
      @messages = @chat_room.messages.includes(:user)
      redirect_to chat_room_path(@chat_room), status: :unprocessable_entity
    end
  end

  private
  def message_params
    params.require(:message).permit(:content, :image).merge(user_id:current_user.id )
  end
end
