class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def send_request
    current_user.friendships.create(friend_id: params[:id])
    flash[:success] = 'Friend request sent'
    redirect_to users_path
  end
end
