class Message < ApplicationRecord
  broadcasts_to ->(message) { "chat_#{message.chat_id}" }
  acts_as_message chat: :chat, tool_calls: :tool_calls, model: :model
end
