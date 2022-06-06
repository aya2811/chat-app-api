class AddColumnsToChat < ActiveRecord::Migration[7.0]
  def change
    add_column :chats, :number, :bigint
  end
end
