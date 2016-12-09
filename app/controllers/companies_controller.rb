class CompaniesController < ApplicationController
  before_action :set_api

  def index
    @companies = @api.companies
  end

  def show
    @company = @api.find_company params[:id]
    @roe = roe
  end

  protected
    def set_api
      @api = IntrinioApi.new
    end

    def roe
      ticker = @company['ticker']
      @net_income = data_point(ticker, 'netincome').to_f
      @total_revenue = data_point(ticker, 'totalrevenue').to_f
      @total_assets = data_point(ticker, 'totalassets').to_f
      @total_equity = data_point(ticker, 'totalequity').to_f

      @profitablity = @net_income/@total_revenue
      @asset_turnover = @total_revenue/@total_assets
      @leverage = @total_assets/@total_equity

      @roe = (@profitablity * @asset_turnover * @leverage).to_f
    end

    def data_point(ticker, item)
      @api.data_point(ticker, item)['value']
    end
end
