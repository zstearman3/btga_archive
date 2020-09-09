Rails.application.routes.draw do
  root 'seasons#index'
  resources :seasons
  resources :courses
  resources :golfers
  resources :tournaments
  get 'roster' => 'golfers#index'
end 
