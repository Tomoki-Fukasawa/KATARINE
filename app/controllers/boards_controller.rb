class BoardsController < ApplicationController
  before_action :require_login,except: [:index, :show]
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
      redirect_to authenticated_root_path
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
    params.permit(:title,:description)
  end

  def set_board
    @board = Board.find(params[:id])
  end

  def require_login
    redirect_to unauthenticated_root_path unless user_signed_in?
  end

  def authenticated_board!
    redirect_to authenticated_root_path unless @board.user == current_user
  end
end
