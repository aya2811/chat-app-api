class App < ApplicationRecord
    validates :name, presence: true
    has_many :chats , class_name: "Chat", foreign_key: "app_id", dependent: :destroy
end
