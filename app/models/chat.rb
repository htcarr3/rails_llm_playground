class Chat < ApplicationRecord
  belongs_to :user, optional: true
  acts_as_chat
end
