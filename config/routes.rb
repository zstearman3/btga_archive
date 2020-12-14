Rails.application.routes.draw do
  root 'seasons#show', id: Season.current_id
  resources :seasons
  resources :courses
  resources :golfers do
    get 'events' => 'golfers#events'
  end
  resources :headlines, only: [:new, :create, :destroy]
  resources :match_play_matchups, only: [:edit, :update]
  resources :tournaments 
  resources :ryder_cup_sessions do
    resources :ryder_cup_rounds
  end
  resources :season_tournaments, :path => "events" do
    resources :golfer_events
  end
  get 'record_book' => 'records#index'
  get 'ryder_cup/:id' => 'ryder_cups#show', as: :ryder_cup
  get 'schedule/:id' => 'season_tournaments#schedule',  as: :schedule
  get 'events/:id/show_matchups' => 'season_tournaments#match_play', as: :match_play
  get 'events/:id/generate_matchups' => 'season_tournaments#generate_matchups', as: :generate_matchups
  get 'roster' => 'golfers#index'
  get 'finalize/:id' => 'season_tournaments#finalize', as: :finalize_event
  get 'unfinalize/:id' => 'season_tournaments#unfinalize', as: :unfinalize_event
  get 'select_default_course' => 'season_tournaments#select_default_course'
  match 'active_headlines' => 'headlines#active_headlines', via: [:get, :post]
end 
