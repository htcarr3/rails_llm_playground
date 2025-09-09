class ChatsController < ApplicationController
  def index
    @chats = Current.user.chats.order(created_at: :desc)
  end

  def show
    @chat = Current.user.chats.find(params[:id])
    @message = Message.new
  end

  def new
    @chat = Current.user.chats.new
  end

  def create
    @chat = Current.user.chats.build(chat_params)
    @chat.model_id ||= "gpt-3.5-turbo"

    if @chat.save
      redirect_to @chat, notice: "New conversation started!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:model_id)
  end
end
