class CompaniesController < ApplicationController
  before_action :set_api

  def index
    if params[:query]
      @companies = @api.companies params[:query]
    else
      @companies = @api.companies
    end
  end

  def show
    @company = Company.new @api.find_company params[:id]
  end
end
