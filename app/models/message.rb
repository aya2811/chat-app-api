require 'elasticsearch/model'

class Message < ApplicationRecord
  validates :number, presence: true
  belongs_to :chat

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  
  Message.__elasticsearch__.create_index!
  Message.import

  def self.search_for_chat(query, chat_id)
    self.search({
      query: {
        bool: {
          must: [
          {
            multi_match: {
              query: query,
              fields: [:text]
            }
          },
          {
            match: {
              chat_id: chat_id
            }
          }]
        }
      }
    })
  end

end




