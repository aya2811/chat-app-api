class AddIndexToChat < ActiveRecord::Migration[7.0]
  def change
    add_index :chats, [:app_id, :number], unique: true
  end
end
