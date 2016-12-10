class IntrinioApi
  include HTTParty
  base_uri 'api.intrinio.com'

  def initialize
    @auth = { username: ENV['API_USERNAME'], password: ENV['API_PASSWORD'] }
  end

  def auth
    @auth
  end

  def companies(query = nil)
    self.class.get("/companies?query=#{query}", basic_auth: self.auth)['data']
  end

  def find_company(id)
    self.class.get("/companies?identifier=#{id}", basic_auth: self.auth)
  end

  def data_point(identifier, item)
    self.class.get("/data_point?identifier=#{identifier}&item=#{item}", basic_auth: self.auth)
  end
end
