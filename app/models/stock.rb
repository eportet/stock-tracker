class Stock < ApplicationRecord
	has_many :user_stocks
	has_many :users, through: :user_stocks

	def self.new_from_lookup(ticker_symbol)
		begin
			looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
			new(name: looked_up_stock.company_name, ticker: looked_up_stock.symbol, last_price: looked_up_stock.latest_price)
		rescue Exception => e
			return nil
		end
	end

	def self.new_from_lookup_crypto(ticker_symbol)
		begin
			n = Cryptocompare::CoinList.all["Data"][ticker_symbol]["CoinName"]
			lp = Cryptocompare::Price.find(ticker_symbol, 'USD')[ticker_symbol]["USD"]
			new(name: n, ticker: ticker_symbol, last_price: lp)
		rescue Exception => e
			return nil
		end
	end

	def get_lp
		looked_up_stock = StockQuote::Stock.quote(self.ticker)
		self.last_price = looked_up_stock.latest_price
		self.save
	end

	def self.find_by_ticker(ticker_symbol)
		where(ticker: ticker_symbol).first
	end

end
