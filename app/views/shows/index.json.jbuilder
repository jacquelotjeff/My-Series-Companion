json.array!(@shows) do |show|
  json.extract! show, :id, :name, :overview, :banner, :poster, :runtime, :network, :rating, :status
  json.url show_url(show, format: :json)
end
