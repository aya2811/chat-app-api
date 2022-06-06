class AddCountColumnToChat < ActiveRecord::Migration[7.0]
  def change
    add_column :chats, :message_count, :bigint
  end
end
