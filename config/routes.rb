Rails.application.routes.draw do
  resources :movies do
    member do
      get :recommended_movies, :similar_movies
    end
  end 
  resources :categories
  resources :actors
end
