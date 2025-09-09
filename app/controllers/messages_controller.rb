class MessagesController < ApplicationController
  before_action :set_chat

  def create
    @message = @chat.messages.build(message_params)
    @message.role = "user"

    if @message.save
      # Generate LLM response using RubyLLM
      generate_llm_response
      redirect_to @chat
    else
      redirect_to @chat, alert: "Failed to send message"
    end
  end

  private

  def set_chat
    @chat = Current.user.chats.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def generate_llm_response
    # Use RubyLLM to generate response
    response = @chat.ask(@message.content)

    if response
      # The response should be automatically saved as a message by RubyLLM's acts_as_chat
      # but we can add error handling here if needed
    end
  rescue => e
    Rails.logger.error "Failed to generate LLM response: #{e.message}"
    # Create an error message for the user
    @chat.messages.create!(
      role: "assistant",
      content: "I apologize, but I'm having trouble responding right now. Please try again.",
      model_id: @chat.model_id
    )
  end
end
