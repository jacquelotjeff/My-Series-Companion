class AddActorsAndGenreToShows < ActiveRecord::Migration
  def change
  	add_column :shows, :genre, :string
  	add_column :shows, :actors, :string
  end
end
