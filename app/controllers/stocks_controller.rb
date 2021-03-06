class StocksController < ApplicationController
	skip_before_action :authenticate_user!, only: [:search]

	def search
		if params[:stock].blank?
		else
			@stock = Stock.new_from_lookup(params[:stock])
			flash.now[:danger] = "No matches were found" unless @stock
		end
		respond_to do |format|
			format.js { render partial: 'stocks/result' }
		end
	end

end
