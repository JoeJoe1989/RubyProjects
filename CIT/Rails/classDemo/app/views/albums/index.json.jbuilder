json.array!(@albums) do |album|
  json.extract! album, :id, :name, :price, :release
  json.url album_url(album, format: :json)
end
