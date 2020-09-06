Rails.application.routes.draw do
  root 'seasons#index'
  resources :seasons
end
