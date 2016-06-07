class Show < ActiveRecord::Base
	extend FriendlyId
	include SearchCop

	has_many :seasons
	has_many :user_shows
	has_many :users, through: :user_shows

	friendly_id :slug_candidates, use: [:slugged, :finders]

	def slug_candidates
		[ :name, [:id, :name] ]
	end

	# Surcharge de FriendlyId pour forcer la mise à jour du nom
	def should_generate_new_friendly_id?
		name_changed? || super
	end

	# Search scope
	search_scope :search do
		attributes :name, :network, :overview
	end
end
