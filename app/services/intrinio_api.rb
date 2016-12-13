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
    Rails.cache.fetch "companies_list_#{query}", expires_in: 5.minutes do
      self.class.get("/companies?query=#{query}", basic_auth: self.auth)['data']
    end
  end

  def find_company(id)
    Rails.cache.fetch "find_company_#{id}", expires_in: 5.minutes do
      company_attribs = self.class.get("/companies?identifier=#{id}", basic_auth: self.auth).first(4)
      to_hash company_attribs
    end
  end

  def data_point(identifier, item)
    Rails.cache.fetch "data_point_#{identifier}_#{item}", expires_in: 5.minutes do
      self.class.get("/data_point?identifier=#{identifier}&item=#{item}", basic_auth: self.auth).parsed_response
    end
  end

  protected

    def to_hash(array)
      hash = {}
      array.each do |attributes|
        hash[attributes.first] = attributes.second
      end
      hash
    end
end
