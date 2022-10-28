class RemoveProcedureFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_reference :users, :procedure, index: true
  end
end
