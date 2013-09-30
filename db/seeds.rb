user = GameTranslator::User.create(name: 'Reviser', email: 'reviser@domain.com',
                    password: '123123123', password_confirmation: '123123123',
                    role: 'reviser')
puts "Reviser-#{user.id} criado!"

5000.times do |i|
  GameTranslator::Game.create(name: "Game #{ i }",
    short_description: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
    long_description: 'Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    instructions: "[mouse] Lorem ipsum dolor")
  puts "Game #{ i } criado!"
end