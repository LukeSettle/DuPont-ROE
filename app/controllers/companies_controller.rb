class CompaniesController < ApplicationController
  before_action :set_api

  def index
    @companies = @api.companies
  end

  protected
    def set_api
      @api = IntrinioApi.new
    end
end
