# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

director_1 = Director.create!(name: 'Wes Anderson', imdb_rank: 20, tv_credit: false)
director_2 = Director.create!(name: 'Steven Spielberg', imdb_rank: 1, tv_credit: true)
director_3 = Director.create!(name: 'George Lucas', imdb_rank: 25, tv_credit: true)

film_1 = director_1.films.create!(name: 'Bottle Rocket', rt_rank: 85, nominated: false)
film_2 = director_1.films.create!(name: 'Life Aquatic', rt_rank: 56, nominated: false)
film_3 = director_3.films.create!(name: 'Star Wars: A New Hope', rt_rank: 92, nominated: true)

gallery_1 = Gallery.create!(name: "Art 4 Us", non_profit: true, entry_cost: 4.75)
gallery_2 = Gallery.create!(name: "Benji's Gallery", non_profit: false, entry_cost: 10)
gallery_3 = Gallery.create!(name: "Zippy Dee Doo Dah", non_profit: false, entry_cost: 5.75)


piece_1 = gallery_1.pieces.create!(name: "Starry Night", artist: "Vincent Van Gogh", year: 1889, original: false)
piece_2 = gallery_1.pieces.create!(name: "Self Portrait", artist: "Vincent Van Gogh", year: 1889, original: true)
piece_3 = gallery_2.pieces.create!(name: "Girl with the Pearl Earring", artist: "Johannes Vermeer", year: 1665, original: false)
piece_3 = gallery_3.pieces.create!(name: "Water lilies", artist: "Claude Monet", year: 1920, original: false)
piece_3 = gallery_3.pieces.create!(name: "Irises in Monet's Garden", artist: "Claude Monet", year: 1920, original: false)
piece_3 = gallery_3.pieces.create!(name: "Impression Sunruse", artist: "Claude Monet", year: 1920, original: false)
