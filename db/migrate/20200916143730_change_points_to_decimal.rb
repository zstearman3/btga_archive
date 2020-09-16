class ChangePointsToDecimal < ActiveRecord::Migration[6.0]
  def change
    change_column :ryder_cup_rounds, :usa_points, :decimal
    change_column :ryder_cup_rounds, :europe_points, :decimal
  end
end
