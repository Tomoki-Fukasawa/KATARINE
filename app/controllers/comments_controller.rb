class CommentsController < ApplicationController
  def create
    @board=Board.find(params[:board_id]) 
    @comment=@board.comments.create(comment_params)
    
    if @comment.save
      redirect_to board_path(@board)
    else
      @comments = @board.comments.includes(:user)
      render 'boards/show', status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
