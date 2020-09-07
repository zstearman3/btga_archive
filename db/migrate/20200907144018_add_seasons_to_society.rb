class AddSeasonsToSociety < ActiveRecord::Migration[6.0]
  def change
    add_reference :seasons, :society, foreign_key: true
  end
end
