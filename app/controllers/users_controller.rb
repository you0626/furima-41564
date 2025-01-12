class UsersController < ApplicationController
  def about
    @users = User.all
  end
end
