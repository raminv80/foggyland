# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

capitals = [
  'Trenton', 'Topeka', 'Tallahassee', 'Springfield', 'Santa Fe',
  'Salt Lake City', 'Salem', 'Saint Paul', 'Sacramento', 'Richmond',
  'Raleigh', 'Providence', 'Pierre', 'Phoenix', 'Olympia', 'Oklahoma City',
  'Nashville', 'Montpelier', 'Montgomery', 'Madison', 'Little Rock', 'Lincoln',
  'Lansing', 'Juneau', 'Jefferson City', 'Jackson', 'Indianapolis', 'Honolulu',
  'Helena', 'Hartford', 'Harrisburg', 'Frankfort', 'Dover', 'Des Moines',
  'Denver', 'Concord', 'Columbus', 'Columbia', 'Cheyenne', 'Charleston',
  'Carson City', 'Boston', 'Boise', 'Bismarck', 'Baton Rouge', 'Austin',
  'Augusta', 'Atlanta', 'Annapolis', 'Albany'
]
country = Country.create(name: 'United States')

CSV.foreach("#{Rails.root}/db/zipcodes.csv", headers: false) do |row|
  next if row.empty?

  zip_code, city_name, state_code = row
  state = country.states.find_or_create_by(code: state_code)
  city = state.cities.find_or_create_by(name: city_name)
  city.zip_codes.create(code: zip_code)
end

City.where(name: capitals).update_all(capital: true)
