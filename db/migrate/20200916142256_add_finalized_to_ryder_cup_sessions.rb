class AddFinalizedToRyderCupSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :ryder_cup_sessions, :finalized, :boolean, default: false
  end
end
