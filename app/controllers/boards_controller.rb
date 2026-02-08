class BoardsController < ApplicationController
  before_action :move_to_index,except: [:index, :show]
  before_action :authenticated_root_path!, only: [:edit, :update, :destroy]

  def index
    @boards = Board.all
  end
  def new
    @board=Board.new
  end
  def create
    @board=Board.create(board_params)
    if @board.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment=Comment.new   
    @board=Board.find(params[:id]) 
    @comments=@board.comments.includes(:user)
  end

  def destroy
    board=Board.find(params[:id])
    board.destroy
    redirect_to '/'
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    board = Board.find(params[:id])
    board.update(board_params)
    redirect_to '/'
  end

  private

  def board_params
    params.require(:board).permit(:title,:description).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to unauthenticated_root_path
    end
  end

  def authorize_board!
    redirect_to authenticated_root_path unless @board.user == current_user
  end
end
