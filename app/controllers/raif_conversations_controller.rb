class RaifConversationsController < ApplicationController
  def index
    @conversations = Raif::Conversations::BasicChat.where(creator: Current.user)
  end

  def create
    @conversation = Raif::Conversations::BasicChat.new(creator: Current.user)
    @conversation.save
    redirect_to raif_conversation_path(@conversation)
  end

  def show
    @conversation = Raif::Conversations::BasicChat.where(creator: Current.user).find(params[:id])
  end
end
