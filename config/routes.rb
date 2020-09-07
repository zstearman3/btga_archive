Rails.application.routes.draw do
  root 'seasons#index'
  resources :seasons
  resources :courses
end
