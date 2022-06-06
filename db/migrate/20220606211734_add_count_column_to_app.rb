class AddCountColumnToApp < ActiveRecord::Migration[7.0]
  def change
    add_column :apps, :chat_count, :bigint
  end
end
