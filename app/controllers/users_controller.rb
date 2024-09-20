class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :first_name, :last_name, :first_name_katakana, :last_name_katakana, :birth, :email,
                                 :password, :password_confirmation)
  end
end
