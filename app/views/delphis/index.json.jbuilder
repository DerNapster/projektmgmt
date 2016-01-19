json.array!(@delphis) do |delphi|
  json.extract! delphi, :id, :username, :workpackage_id, :workpackagename, :value
  json.url delphi_url(delphi, format: :json)
end
