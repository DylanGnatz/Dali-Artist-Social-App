class SwipesMakeSwipedIdNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null  :swipes, :swiped_id, true
  end
end
