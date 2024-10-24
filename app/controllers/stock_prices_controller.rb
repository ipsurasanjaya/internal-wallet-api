require 'latest_stock_price/stock_price_api'

class StockPricesController < ApplicationController
    def show_price
        identifier = params[:Identifier]
        stock_data = StockPriceAPI.prices(identifier)
        render json: stock_data
    end
end
