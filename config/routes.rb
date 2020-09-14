Rails.application.routes.draw do
  root 'season_tournaments#schedule', id: Season.current_id
  resources :seasons
  resources :courses
  resources :golfers
  resources :tournaments 
  resources :season_tournaments, :path => "events" do
    resources :golfer_events
  end
  get 'schedule/:id' => 'season_tournaments#schedule',  as: :schedule
  get 'roster' => 'golfers#index'
  get 'finalize/:id' => 'season_tournaments#finalize', as: :finalize_event
  get 'unfinalize/:id' => 'season_tournaments#unfinalize', as: :unfinalize_event
end 
