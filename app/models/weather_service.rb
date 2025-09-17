class WeatherService
  API_BASE_URL = "https://api.open-meteo.com/v1/forecast"

  def self.fetch_weather(latitude:, longitude:)
    new.fetch_weather(latitude: latitude, longitude: longitude)
  end

  def fetch_weather(latitude:, longitude:)
    url = build_url(latitude: latitude, longitude: longitude)

    response = Faraday.get(url)
    JSON.parse(response.body)
  rescue => e
    { error: e.message }
  end

  private

  def build_url(latitude:, longitude:)
    params = {
      temperature_unit: "fahrenheit",
      latitude: latitude,
      longitude: longitude,
      current: "temperature_2m,wind_speed_10m"
    }

    "#{API_BASE_URL}?#{URI.encode_www_form(params)}"
  end
end
