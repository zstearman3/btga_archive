class AddNameToRyderCup < ActiveRecord::Migration[6.0]
  def change
    add_column :ryder_cups, :name, :string
  end
end
