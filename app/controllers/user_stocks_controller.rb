class UserStocksController < ApplicationController
	def create
		stock = Stock.find_by_ticker(params[:stock_ticker])
		if stock.blank?
			stock = Stock.new_from_lookup(params[:stock_ticker])
			stock.save
		end
		@user_stock = UserStock.create(user: current_user, stock: stock)
		flash[:success] = "You are now following the #{@user_stock.stock.ticker} stock!"
		redirect_to portfolio_path
	end

	def destroy
		stock = Stock.find(params[:id])
		@user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
		@user_stock.destroy
		redirect_to portfolio_path
	end
end
