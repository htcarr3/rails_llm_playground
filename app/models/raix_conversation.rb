class RaixConversation
  include Raix::ChatCompletion
  include Raix::PromptDeclarations
  attr_accessor :chat, :user_prompt
  OPENAI_MODEL = "gpt-4o"

  prompt call: RaixHelpfulAssistant,
         if: -> { transcript.count < 10 }

  prompt call: RaixClassClown,
         if: -> { transcript.count > 10 }

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
end
