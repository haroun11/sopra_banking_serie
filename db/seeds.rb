# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

#Serie.destroy_all
#Actor.destroy_all
#ShootLocation.destroy_all

csv_text = File.read(Rails.root.join('lib', 'seeds', 'tv_series.csv'))
csv = CSV.parse(csv_text.scrub, headers: true)

csv.each do |row|
  serie_exist = Serie.where(name: row['TV Series']).first
  actor_exist = Actor.where(name: row['Actor']).first
#Actor table
  if actor_exist == nil
    actor = Actor.new
    actor.name = row['Actor']
    actor.save
  end
#Serie table
  if serie_exist == nil
    serie = Serie.new
    serie.name = row['TV Series']
    serie.genre = row['Genre']
    serie.nb_of_seasons = row['No of seasons']
    serie.date_of_first_release = row['Date of First Release']
    serie.director = row['Director']
    serie.country = row['Country']
    serie.save
  end

  serie_id = Serie.where(name: row['TV Series']).first.id
  actor_id = Actor.where(name: row['Actor']).first.id
#ShootLocation table
  shoot_location = ShootLocation.new
  shoot_location.actor_id = actor_id
  shoot_location.serie_id = serie_id
  shoot_location.location = row['Shoot location']
  shoot_location.save
  
end

puts "There are now #{Serie.count} rows in the Serie table"
puts "There are now #{Actor.count} rows in the Actor table"
puts "There are now #{ShootLocation.count} rows in the ShootLocation table"

#review table
Review.destroy_all
csv_text = File.read(Rails.root.join('lib', 'seeds', 'reviews.csv'))
csv = CSV.parse(csv_text.scrub, headers: true)
csv.each do |row|
  serie_id = Serie.where(name: row['TV Series']).first.id
  t = Review.new
  t.user = row['User']
  t.serie_id = serie_id
  t.stars = row['Stars']
  t.review = row['Review']
  t.save
  puts "#{t.review}, for serie #{row['TV Series']} saved"
end

puts "There are now #{Review.count} rows in the Review table"