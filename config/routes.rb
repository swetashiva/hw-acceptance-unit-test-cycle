Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get 'movies_by_same_director/:title' => 'movies#search', as: :search_movies_by_same_director
end
