class RaifConversationEntriesController < ApplicationController
  before_action :set_conversation
  def create
    @conversation_entry = Raif::ConversationEntry.new(conversation_entry_params)
    @conversation_entry.raif_conversation = @conversation
    @conversation_entry.creator = Current.user
    @conversation_entry.user_message = conversation_entry_params[:user_message]
    if @conversation_entry.save
      # Start the conversation entry processing
      @conversation_entry.start!

      # Return immediate response with Turbo Stream
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append("messages-container", partial: "raif_conversation_entries/conversation_entry", locals: { conversation_entry: @conversation_entry }),
            turbo_stream.append("messages-container", partial: "raif_conversation_entries/typing_indicator", locals: { conversation: @conversation })
          ]
        end
        format.html { redirect_to @conversation }
      end
    else
      redirect_to @conversation, alert: "Failed to create message"
    end
  end

  private

  def set_conversation
    @conversation = Raif::Conversation.where(creator: Current.user).find(params[:raif_conversation_id])
  end

  def conversation_entry_params
    params.require(:raif_conversation_entry).permit(:user_message)
  end
end
