class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end
  def new
    @board=Board.new
  end
  def create
    Board.create(board_params)
    if @board.save
      redirect_to :index
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def board_params
    params.require(:board).permit(:title,:description).merge(user_id: current_user.id)
  end
end
