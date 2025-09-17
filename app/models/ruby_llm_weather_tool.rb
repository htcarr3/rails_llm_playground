class RubyLlmWeatherTool < RubyLLM::Tool
  description "Gets current weather for a location"
  param :latitude, desc: "Latitude (e.g., 52.5200)"
  param :longitude, desc: "Longitude (e.g., 13.4050)"

  def execute(latitude:, longitude:)
    WeatherService.fetch_weather(latitude: latitude, longitude: longitude)
  end
end
