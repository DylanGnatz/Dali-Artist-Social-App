class AddLocationToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :lat, :decimal, {:precision=>10, :scale=>6}
    add_column :profiles, :lng, :decimal, {:precision=>10, :scale=>6}
  end
end
