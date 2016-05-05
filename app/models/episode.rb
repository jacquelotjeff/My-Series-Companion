class Episode < ActiveRecord::Base
	belongs_to :season
	has_many :user_episodes
	has_many :users, through: :user_episodes
end
