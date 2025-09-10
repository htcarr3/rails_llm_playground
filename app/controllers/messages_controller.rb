class MessagesController < ApplicationController
  before_action :set_chat

  def create
    @message = @chat.messages.build(message_params)
    @message.role = "user"
    # Don't save this message, it will be saved by the LLM response job
    GenerateLlmResponseJob.perform_later(@chat.id, message_params[:content])

    # Return immediate response with Turbo Stream
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.append("messages-container", partial: "messages/message", locals: { message: @message }),
          turbo_stream.append("messages-container", partial: "messages/typing_indicator", locals: { chat: @chat })
        ]
      end
      format.html { redirect_to @chat }
    end
  end

  private

  def set_chat
    @chat = Current.user.chats.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
