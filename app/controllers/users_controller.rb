class UsersController < ApplicationController
  def about
    @users = User.all
  end

  def privacy_policy
    @users = User.all
  end

  def service
    @users = User.all
  end

  def point
    @users = User.all
  end
end
