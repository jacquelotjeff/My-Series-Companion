json.array!(@series) do |series|
  json.extract! series, :id, :name, :overview, :banner, :poster, :runtime, :network, :rating, :status
  json.url series_url(series, format: :json)
end
