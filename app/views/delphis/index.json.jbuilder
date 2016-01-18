json.array!(@delphis) do |delphi|
  json.extract! delphi, :id, :name, :workpackage_id, :round, :pessimistic, :realistic, :optimistic
  json.url delphi_url(delphi, format: :json)
end
