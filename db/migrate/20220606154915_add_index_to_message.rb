class AddIndexToMessage < ActiveRecord::Migration[7.0]
  def change
    add_index :messages, [:chat_id, :number], unique: true
  end
end
