 class FriendshipsController < ApplicationController
	def destroy
		@friendship = current_user.friendships.where(friend_id: params[:id]).first
		@friendship.destroy
		flash[:notice] = "You have ended your friendship with #{User.find(params[:id]).full_name} :("
		redirect_to friends_path
	end
end
