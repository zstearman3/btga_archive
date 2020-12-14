class AddLoserToMatchPlayMatchups < ActiveRecord::Migration[6.0]
  def change
    add_column :match_play_matchups, :loser_golfer_id, :integer
    add_column :match_play_matchups, :losers_bracket, :boolean, default: false
  end
end
