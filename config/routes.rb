Rails.application.routes.draw do
  root 'seasons#show', id: Season.current_id
  resources :seasons
  resources :courses
  resources :golfers
  resources :tournaments 
  resources :ryder_cup_sessions do
    resources :ryder_cup_rounds
  end
  resources :season_tournaments, :path => "events" do
    resources :golfer_events
  end
  get 'ryder_cup/:id' => 'ryder_cups#show', as: :ryder_cup
  get 'schedule/:id' => 'season_tournaments#schedule',  as: :schedule
  get 'roster' => 'golfers#index'
  get 'finalize/:id' => 'season_tournaments#finalize', as: :finalize_event
  get 'unfinalize/:id' => 'season_tournaments#unfinalize', as: :unfinalize_event
  get 'select_default_course' => 'season_tournaments#select_default_course'
end 
