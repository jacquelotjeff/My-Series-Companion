class AddSlugToShows < ActiveRecord::Migration
  def change
  	add_column :shows, :slug, :string, unique: true, index: true
  end
end
