class CreateUserEpisodes < ActiveRecord::Migration
  def change
    create_table :user_episodes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :episode, index: true, foreign_key: true
      t.boolean :viewed

      t.timestamps null: false
    end
  end
end
