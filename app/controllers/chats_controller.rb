class ChatsController < ApplicationController
  before_action :set_chat, only: [ :show ]

  def index
    @chats = Current.user.chats.order(created_at: :desc)
  end

  def new
    @chat = Chat.new
    @selected_model = params[:model]
  end

  def create
    return unless prompt.present?

    @chat = Current.user.chats.create!(model: model)
    ChatResponseJob.perform_later(@chat.id, prompt)

    redirect_to @chat, notice: "Chat was successfully created."
  end

  def show
    @message = @chat.messages.build
  end

  private

  def set_chat
    @chat = Current.user.chats.find(params[:id])
  end

  def model
    params[:chat][:model].presence
  end

  def prompt
    params[:chat][:prompt]
  end
end
