class AddUpdatedNameToTouraments < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :updated_name, :string
    add_column :tournaments, :name_updated_year, :integer
  end
end
