Rails.application.routes.draw do
  root 'seasons#index'
  resources :seasons
  resources :courses
  resources :golfers
  get 'roster' => 'golfers#index'
end 
