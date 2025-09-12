class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :messages, through: :chats
  has_many :raix_chats, dependent: :destroy
  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
