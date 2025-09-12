class RaixConversation
  include Raix::ChatCompletion
  include Raix::FunctionDispatch
  attr_accessor :chat, :user_prompt
  SYSTEM_DIRECTIVE = "You are a helpful assistant. Answer the user's question in a friendly tone."
  OPENAI_MODEL = "gpt-4o"

  function :check_weather,
           "Check the weather for a location",
           location: { type: "string", required: true } do |arguments|
    "The weather in #{arguments[:location]} is hot and sunny"
  end

  function :get_time, "Get the current time" do |_arguments|
    "The time is #{Time.now}"
  end


  def initialize(chat:)
    @chat = chat
    chat.messages.each do |message|
      transcript << message.to_transcript_hash
    end
  end

  def ask_question(question)
    chat.messages.create(role: "user", content: question, model_id: OPENAI_MODEL) do |message|
      transcript << { user: question }
    end
    chat_completion(openai: OPENAI_MODEL).tap do |response|
      chat.messages.create(role: "assistant", content: response, model_id: OPENAI_MODEL)
    end
  end

  def dispatch_tool_function(function_name, arguments)
    puts "Calling #{function_name} with #{arguments}"
    super.tap do |result|
      puts "Result: #{result}"
    end
  end
end
