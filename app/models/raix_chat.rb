class RaixChat < ApplicationRecord
  belongs_to :user
  has_many :messages, class_name: "RaixMessage", dependent: :destroy
end
