Rails.application.routes.draw do
  root 'seasons#index'
  resources :seasons
  resources :courses
  resources :golfers
  resources :tournaments 
  resources :season_tournaments, :path => "events"
  get 'schedule/:id' => 'season_tournaments#schedule',  as: :schedule
  get 'roster' => 'golfers#index'
end 
