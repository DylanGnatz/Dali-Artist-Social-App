class FixUserColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :pseudo, :username
  end
end
