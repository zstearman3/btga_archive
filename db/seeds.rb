# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
s = Society.find_or_create_by(name: 'BTGA')
s.abbreviation = 'BTGA'
s.save

Record.delete_all
Record.create([
  {id: 1, name: 'Best Round (Strokes)', society: Society.first, decimal_places: 0},
  {id: 2, name: 'Best Round (To Par)', society: Society.first, decimal_places: 0}
])