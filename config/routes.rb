Rails.application.routes.draw do
  resources :movies do
    member do
      get :recommended_movies, :similar_movies
    end
  end 
  resources :categories
  resources :actors do
    member do
      get :actor_movies
    end
  end
end
