class WeatherService
  include HTTParty
  base_uri 'http://api.weatherstack.com'

  def initialize(city)
    @city = city
    @options = { query: { access_key: 'cddcef38fb6ec7c321b5f1a7f12b3301', query: "#{city.latitude},#{city.longitude}" } }
  end

  def fetch_temperature
    response = self.class.get('/current', @options)

    Rails.logger.info("Weather API response: #{response.body}")

    if response.success?
      # Use dig to extract temperature, with default to handle missing keys
      temperature = response.parsed_response.dig('current', 'temperature')
      if temperature
        Rails.logger.info("Fetched temperature: #{temperature}°C")
        temperature
      else
        Rails.logger.error("Temperature data not found in API response")
        nil
      end
    else
      Rails.logger.error("Weather API request failed with code #{response.code}")
      nil
    end
  end
end
