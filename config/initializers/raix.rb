Raix.configure do |config|
  retry_options = {
    max: 2,
    interval: 0.05,
    interval_randomness: 0.5,
    backoff_factor: 2
  }
  open_ai_api_key = ENV["OPENAI_API_KEY"] || Rails.application.credentials.dig(:openai, :api_key)
  config.openai_client = OpenAI::Client.new(access_token: open_ai_api_key) do |f|
    f.request :retry, retry_options
  end
end
