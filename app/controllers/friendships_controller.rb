class FriendshipsController < ApplicationController
  # before_action :authenticate_user!

  def index
    @friends = current_user.friends
    @friend_requests = current_user.incoming_requests
  end

  def create
    current_user.friendships.create(friend_id: params[:id])
    flash[:success] = 'Friend request sent'
    redirect_to friendships_path
  end

  def update
    user = User.find(params[:id])
    current_user.confirm_friend(user)
    flash[:success] = 'Friend accepted'
    redirect_to friendships_path
  end

  def destroy
    @friend = current_user.reverse_friendships.find_by(user_id: params[:id])
    @friend = current_user.friendships.find_by(friend_id: params[:id]) if @friend.nil?

    current_user.remove_reverse_friend @friend
    redirect_to friendships_path
  end
end
