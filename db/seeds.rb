# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
state_codes = [
  'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN',
  'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV',
  'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN',
  'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'
]
state_names = [
  'Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado',
  'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii', 'Idaho',
  'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana',
  'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota',
  'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada',
  'New Hampshire', 'New Jersey', 'New Mexico', 'New York',
  'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma',
  'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina',
  'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont',
  'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming'
]
capitals = [
  'Montgomery', 'Juneau', 'Phoenix', 'Little Rock', 'Sacramento', 'Denver',
  'Hartford', 'Dover', 'Tallahassee', 'Atlanta', 'Honolulu', 'Boise',
  'Springfield', 'Indianapolis', 'Des Moines', 'Topeka', 'Frankfort',
  'Baton Rouge', 'Augusta', 'Annapolis', 'Boston', 'Lansing', 'Saint Paul',
  'Jackson', 'Jefferson City', 'Helena', 'Lincoln', 'Carson City', 'Concord',
  'Trenton', 'Santa Fe', 'Albany', 'Raleigh', 'Bismarck', 'Columbus',
  'Oklahoma City', 'Salem', 'Harrisburg', 'Providence', 'Columbia', 'Pierre',
  'Nashville', 'Austin', 'Salt Lake City', 'Montpelier', 'Richmond', 'Olympia',
  'Charleston', 'Madison', 'Cheyenne'
]
country = Country.find_or_create_by(name: 'United States')

CSV.foreach("#{Rails.root}/db/zipcodes.csv", headers: false, skip_blanks: true) do |row|
  zip_code, city_name, state_code = row
  state = State.find_or_create_by(code: state_code, country: country)
  city = City.find_or_create_by(name: city_name, state: state)
  ZipCode.create(code: zip_code, city: city)
end

(0...50).each do |i|
  City
    .joins(:state)
    .where(name: capitals[i], states: { code: state_codes[i] })
    .first
    .update(capital: true)
  State.where(code: state_codes[i]).first.update(name: state_names[i])
end
