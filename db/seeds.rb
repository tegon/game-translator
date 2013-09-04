require 'ffaker'

50.times do |i|
  Game.create(name: "Game #{ i }", short_description: Faker::Lorem.sentence, long_description: Faker::Lorem.paragraphs.join, instructions: "[mouse] #{ Faker::Name.name }")
  puts "Game #{ i } criado!"
end