class MessagesController < ApplicationController
  def create
    @chat_room=Chat_room.find(params[:chat_room_id])
    @message=@chat_room.message.new(message_params)
  end

  private
  def message_params
    params.require(:message).permit(:content, :image).merge(user1_id:[],user2_ids: [])
  end
end
