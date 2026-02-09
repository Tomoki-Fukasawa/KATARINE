class BoardsController < ApplicationController
  before_action :authenticate_user!,except: [:index, :show]
  before_action :set_board, only: [:show,:edit,:update,:destroy]
  before_action :authenticated_board!, only: [:edit, :update, :destroy]

  def index
    @boards = Board.all
  end
  def new
    @board=Board.new
  end
  def create
    @board=current_user.boards.new(board_params)
    if @board.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment=Comment.new   
    @comments=@board.comments.includes(:user)
  end

  def destroy
    @board.destroy
    redirect_to '/'
  end

  def edit
  end

  def update
    @board.update(board_params)
    redirect_to '/'
  end

  private

  def board_params
    params.require(:board).permit(:title,:description).merge(user_id: current_user.id)
  end

  def set_board
    @board = Board.find(params[:id])
  end

  def authenticated_board!
    redirect_to root_path unless @board.user == current_user
  end
end
