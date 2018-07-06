class UsersController < ApplicationController

	def portfolio
		@user = current_user
		@user_stocks = current_user.stocks
	end

	def friends
		@friendships = current_user.friends
	end

	def add_friend
		@friend =User.find(params[:friend])
		current_user.friendships.build(friend_id: @friend.id)
		if current_user.save
			flash[:success] = "#{@friend.full_name} was added as a friend!"
		else
			flash[:danger] = "Oops! Something went wrong processing that request"
		end
		redirect_to friends_path
	end

	def search
		if params[:search_param].blank?
		else
			@users = User.search(params[:search_param])
			@users =current_user.except_current_user(@users)
			flash.now[:danger] = "No matches were found" if @users.blank?
		end
		respond_to do |format|
			format.js { render partial: 'friends/results' }
		end
	end

	def show
		@user = User.find(params[:id ])
		@user_stocks = @user.stocks
	end

end
