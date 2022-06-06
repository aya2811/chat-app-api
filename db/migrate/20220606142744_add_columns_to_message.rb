class AddColumnsToMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :number, :bigint
    add_column :messages, :text, :string
  end
end
