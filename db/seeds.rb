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
