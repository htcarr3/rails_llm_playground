class GenerateLlmResponseJob < ApplicationJob
  queue_as :default

  def perform(chat_id, message_content)
    chat = Chat.find(chat_id)
    begin
      # Generate LLM response using RubyLLM
      response = chat.ask(message_content)

      if response
        # Find the assistant message that was created by RubyLLM
        assistant_message = chat.messages.where(role: "assistant").last

        # Broadcast the new message to the chat stream
        broadcast_message_to_chat(chat, assistant_message) if assistant_message
      end

    rescue => e
      Rails.logger.error "Failed to generate LLM response: #{e.message}"

      # Create an error message for the user
      error_message = chat.messages.create!(
        role: "assistant",
        content: "I apologize, but I'm having trouble responding right now. Please try again.",
        model_id: chat.model_id
      )

      # Broadcast the error message
      broadcast_message_to_chat(chat, error_message)
    end
  end

  private

  def broadcast_message_to_chat(chat, message)
    # Remove typing indicator and broadcast the new message
    Turbo::StreamsChannel.broadcast_remove_to("chat_#{chat.id}", target: "typing-indicator")
    Turbo::StreamsChannel.broadcast_append_to(
      "chat_#{chat.id}",
      target: "messages-container",
      partial: "messages/message",
      locals: { message: message }
    )
  end
end
