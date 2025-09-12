class GenerateRaixResponseJob < ApplicationJob
  queue_as :default

  def perform(raix_chat_id, message_content)
    raix_chat = RaixChat.find(raix_chat_id)
    begin
      # Generate LLM response using RaixConversation
      raix_conversation = RaixConversation.new(chat: raix_chat)
      response = raix_conversation.ask_question(message_content)

      if response
        # Find the assistant message that was created by RaixConversation
        assistant_message = raix_chat.messages.where(role: "assistant").last
        broadcast_message_to_raix_chat(raix_chat, assistant_message) if assistant_message
      end

    rescue => e
      Rails.logger.error "Failed to generate Raix response: #{e.message}"

      # Create an error message for the user
      error_message = raix_chat.messages.create!(
        role: "assistant",
        content: "I apologize, but I'm having trouble responding right now. Please try again.",
        model_id: RaixConversation::OPENAI_MODEL
      )

      # Broadcast the error message
      broadcast_message_to_raix_chat(raix_chat, error_message)
    end
  end

  private

  def broadcast_message_to_raix_chat(raix_chat, message)
    # Remove typing indicator and broadcast the new message
    Turbo::StreamsChannel.broadcast_remove_to("raix_chat_#{raix_chat.id}", target: "typing-indicator")
    Turbo::StreamsChannel.broadcast_append_to(
      "raix_chat_#{raix_chat.id}",
      target: "messages-container",
      partial: "raix_messages/message",
      locals: { message: message }
    )
  end
end
