class IntrinioApi
  include HTTParty
  base_uri 'api.intrinio.com'

  def initialize
    @auth = { username: ENV['API_USERNAME'], password: ENV['API_PASSWORD'] }
  end

  def auth
    @auth
  end

  def companies
    self.class.get('/companies', basic_auth: self.auth)['data']
  end
end
