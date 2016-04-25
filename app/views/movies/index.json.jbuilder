json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :director, :runtime_in_minutes, :description, :poster_image_url, :release_date
  json.url movie_url(movie, format: :json)
end
