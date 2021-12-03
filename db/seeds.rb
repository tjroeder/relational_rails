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


gallery_1 = Gallery.create!(name: "Art 4 Us", non_profit: true, entry_cost: 4.75)
gallery_2 = Gallery.create!(name: "Benji's Gallery", non_profit: false, entry_cost: 10)

piece_1 = gallery_1.piece.create!(name: "Starry Night", artist: "Vincent Van Gogh", year: 1889, original: false)
piece_2 = gallery_1.piece.create!(name: "Self Portrait", artist: "Vincent Van Gogh", year: 1889, original: true)
piece_3 = gallery_2.piece.create!(name: "Girl with the Pearl Earring", artist: "Johannes Vermeer", year: 1665, original: false)
