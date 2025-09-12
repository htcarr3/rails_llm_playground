class RaixMessage < ApplicationRecord
  belongs_to :chat, class_name: "RaixChat", foreign_key: "raix_chat_id"
  has_one :user, through: :chat
  enum :role, %w[user assistant].index_by(&:itself)

  def to_transcript_hash
    { role.to_sym => content }
  end
end
