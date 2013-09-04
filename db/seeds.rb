50.times do |i|
  Game.create(name: "Game #{ i }",
    short_description: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod
    tincidunt ut laoreet dolore magna aliquam erat volutpat.',
    long_description: 'Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    instructions: "[mouse] Lorem ipsum dolor")
  puts "Game #{ i } criado!"
end