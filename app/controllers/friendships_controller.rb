class FriendshipsController < ApplicationController
  def destroy
    @friendships = current_user.friendships.where(friend_id: params[:id]).first
    @friendships.destroy
    flash[:notice] = "Friend was successfully removed"
    redirect_to my_friends_path
  end
end
