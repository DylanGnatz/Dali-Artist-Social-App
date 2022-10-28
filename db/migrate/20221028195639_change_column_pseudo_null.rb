class ChangeColumnPseudoNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :pseudo, false
  end
end
