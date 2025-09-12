class RaixMessagesController < ApplicationController
  before_action :set_raix_chat

  def create
    @raix_message = @raix_chat.messages.build(raix_message_params)
    @raix_message.role = "user"
    # Don't save this message, it will be saved by the LLM response job
    GenerateRaixResponseJob.perform_later(@raix_chat.id, raix_message_params[:content])

    # Return immediate response with Turbo Stream
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.append("messages-container", partial: "raix_messages/message", locals: { message: @raix_message }),
          turbo_stream.append("messages-container", partial: "raix_messages/typing_indicator", locals: { raix_chat: @raix_chat })
        ]
      end
      format.html { redirect_to @raix_chat }
    end
  end

  private

  def set_raix_chat
    @raix_chat = Current.user.raix_chats.find(params[:raix_chat_id])
  end

  def raix_message_params
    params.require(:raix_message).permit(:content)
  end
end
