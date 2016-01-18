json.array!(@delphis) do |delphi|
  json.extract! delphi, :id, :name, :workpackage_id, :value
  json.url delphi_url(delphi, format: :json)
end
