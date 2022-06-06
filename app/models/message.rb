require 'elasticsearch/model'

class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :number, presence: true
  belongs_to :chat
end


