class User < ActiveRecord::Base
	has_many :user_episodes
	has_many :episodes, through: :user_episodes
	has_many :user_shows
	has_many :shows, through: :user_shows
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable
end
