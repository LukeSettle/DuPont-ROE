class Company
  attr_accessor :name, :ticker, :lei, :legal_name

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def historical_data(item, start_date, end_date)
    data = IntrinioApi.new.historical_data(ticker, item, start_date, end_date)['data']
    data.map { |point| { DateTime.parse(point['date']).to_s => point['value'] }}.reduce Hash.new, :merge
  end

  def historical_equation_data(point_one, point_two)
    historical_point_one = historical_data(point_one, 5.year.ago, Date.today)
    historical_point_two = historical_data(point_two, 5.year.ago, Date.today)
    array = historical_point_one.values.map.with_index do |one_val, index|
      { historical_point_one.keys[index] => one_val/historical_point_two.values[index] }
    end
    array.reduce Hash.new, :merge
  end

  def historical_profitability
    historical_equation_data('totalrevenue', 'netincome')
  end

  def historical_asset_turnover
    historical_equation_data('totalrevenue', 'totalassets')
  end

  def historical_leverage
    historical_equation_data('totalassets', 'totalequity')
  end

  def historical_roe_graph_data
    [
      { name: 'Profitablity', data: historical_profitability },
      { name: 'Asset Turnover', data: historical_asset_turnover },
      { name: 'Leverage', data: historical_leverage }
    ]
  end

  def roe
    (profitablity * asset_turnover * leverage).to_f
  end

  def data_point(ticker, item)
    api.data_point(ticker, item)['value']
  end

  def api
    IntrinioApi.new
  end

  def net_income
    data_point(ticker, 'netincome').to_f
  end

  def total_revenue
    data_point(ticker, 'totalrevenue').to_f
  end

  def total_assets
    data_point(ticker, 'totalassets').to_f
  end

  def total_equity
    data_point(ticker, 'totalequity').to_f
  end

  def profitablity
    net_income/total_revenue
  end

  def asset_turnover
    total_revenue/total_assets
  end

  def leverage
    total_assets/total_equity
  end
end
