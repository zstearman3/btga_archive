class AddTypesToTournaments < ActiveRecord::Migration[6.0]
  def change
    add_reference :tournaments, :tournament_type, foreign_key: true
  end
end
