class CommentsController < ApplicationController
  def create
    comment=Comment.create(comment_params)
    comments=Comments.all
    redirect_to "/boards/show/#{comment.boards.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, board_id: params[:boards_id])
  end
end
