class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_search
  before_action :check_search

  def check_search
    query = params.try(:[], :search).try(:[], :query)
    if query
      redirect_to companies_path(query: query)
    end
  end

  protected
    def set_search
      @search = Search.new
    end

    def set_api
      @api = IntrinioApi.new
    end
end
