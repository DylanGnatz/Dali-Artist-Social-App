class UpdateCollectiveArtworksForeignKey < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :collective_artworks, :collectives
    add_foreign_key :collective_artworks, :collectives, on_delete: :cascade
  end
end
