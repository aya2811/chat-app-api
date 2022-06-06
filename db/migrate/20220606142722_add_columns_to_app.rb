class AddColumnsToApp < ActiveRecord::Migration[7.0]
  def change
    add_column :apps, :token, :string
    add_index :apps, :token, unique: true
  end
end
