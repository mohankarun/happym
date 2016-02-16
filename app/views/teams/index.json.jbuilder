json.array!(@teams) do |team|
  json.extract! team, :id, :name, :desc, :active
  json.url team_url(team, format: :json)
end
