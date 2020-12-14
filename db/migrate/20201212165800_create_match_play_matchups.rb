class CreateMatchPlayMatchups < ActiveRecord::Migration[6.0]
  def change
    create_table :match_play_matchups do |t|
      t.integer :favorite_golfer_id
      t.integer :underdog_golfer_id
      t.integer :rounded_value
      t.integer :favorite_seed
      t.integer :underdog_seed
      t.integer :strokes_up
      t.integer :holes_to_play
      t.integer :winner_golfer_id
      t.belongs_to :season_tournament
      t.boolean :final
      t.integer :winner_place
      t.integer :loser_place
      
      t.timestamps
    end
  end
end
