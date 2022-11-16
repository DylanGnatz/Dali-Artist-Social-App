class AddTimestampsToArtwork < ActiveRecord::Migration[7.0]
  def change
    change_table(:artworks) { |t| t.timestamps }
  end
end
