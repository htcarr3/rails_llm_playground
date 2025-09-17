class RaixHelpfulAssistant
  include Raix::ChatCompletion
  include Raix::FunctionDispatch
  attr_accessor :context

  function :check_weather,
           "Check the weather for a location",
           latitude: {
             type: "string",
             description: "Latitude (e.g., 52.5200)",
             required: true
           },
           longitude: {
             type: "string",
             description: "Longitude (e.g., 52.5200)",
             required: true
           } do |arguments|
    WeatherService.fetch_weather(
      latitude: arguments[:latitude],
      longitude: arguments[:longitude]
    )
  end

  function :get_time, "Get the current time" do |_arguments|
    "The time is #{Time.now}"
  end

  def initialize(context)
    self.context = context
    self.transcript.concat(context.transcript)
  end

  def call(_input)
    response = chat_completion(openai: RaixConversation::OPENAI_MODEL)
    "#{response} \n- RaixHelpfulAssistant"
  end

  def dispatch_tool_function(function_name, arguments)
    puts "Calling #{function_name} with #{arguments}"
    super.tap do |result|
      puts "Result: #{result}"
    end
  end
end
