class UsersController < ApplicationController
  def show
    @nickname=current_user.nickname
    @birth_day=current_user.birthday
  end
end
