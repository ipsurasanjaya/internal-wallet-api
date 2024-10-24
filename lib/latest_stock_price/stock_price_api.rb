require 'net/http'
require 'json'
require 'uri'

class StockPriceAPI
  BASE_URL = "https://latest-stock-price.p.rapidapi.com"
  API_KEY = "secret-key"
  HEADERS = {
    "x-rapidapi-host" => "latest-stock-price.p.rapidapi.com",
    "x-rapidapi-key" => API_KEY,
    "Content-Type" => "application/json"
  }

  def self.prices(identifier)

    url = URI("#{BASE_URL}/any?Identifier=#{identifier}")
    response = fetch_data(url)
    parse_response(response)
  end

  private

  def self.fetch_data(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url, HEADERS)

    http.request(request)
  end

  def self.parse_response(response)
    JSON.parse(response.body)
  rescue JSON::ParserError => e
    { error: "Invalid JSON response", message: e.message }
  end
end
