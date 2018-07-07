class PagesController < ApplicationController
	skip_before_action :authenticate_user!, only: [:home]

	def home
		if !current_user.blank?
			@user = current_user
			@user_stocks = current_user.stocks
		end
	end
end
