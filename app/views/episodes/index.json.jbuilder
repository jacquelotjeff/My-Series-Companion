json.array!(@episodes) do |episode|
  json.extract! episode, :id, :name, :number, :firstaired, :overview, :rating, :ratingcount, :season_id, :filename
  json.url episode_url(episode, format: :json)
end
