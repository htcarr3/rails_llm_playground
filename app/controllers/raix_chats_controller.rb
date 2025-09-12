class RaixChatsController < ApplicationController
  def index
    @raix_chats = Current.user.raix_chats.order(created_at: :desc)
  end

  def show
    @raix_chat = Current.user.raix_chats.find(params[:id])
    @raix_message = RaixMessage.new
  end

  def new
    @raix_chat = Current.user.raix_chats.new
  end

  def create
    @raix_chat = Current.user.raix_chats.build(raix_chat_params)

    if @raix_chat.save
      redirect_to @raix_chat, notice: "New Raix conversation started!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def raix_chat_params
    params.require(:raix_chat).permit(:model_id)
  end
end
