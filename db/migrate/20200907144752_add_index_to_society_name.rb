class AddIndexToSocietyName < ActiveRecord::Migration[6.0]
  def change
    add_index(:societies, :name)
  end
end
