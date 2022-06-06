class Chat < ApplicationRecord
  validates :number, presence: true
  belongs_to :app
  has_many :messages, class_name: "Message", foreign_key: "chat_id", dependent: :destroy
end
