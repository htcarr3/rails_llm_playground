class ChatResponseJob < ApplicationJob
  def perform(chat_id, content)
    chat = Chat.find(chat_id)
    chat.with_tools(RubyLlmWeatherTool)
    chat.ask(content) do |chunk|
      if chunk.content && !chunk.content.blank?
        message = chat.messages.last
        message.update!(content: message.content + chunk.content)
      end
    end
  end
end
