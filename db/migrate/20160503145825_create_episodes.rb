class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :name
      t.integer :number
      t.date :firstaired
      t.string :overview
      t.float :rating
      t.integer :ratingcount
      t.references :season, index: true, foreign_key: true
      t.string :filename

      t.timestamps null: false
    end
  end
end
