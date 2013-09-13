GameTranslator
--------------

> Set up Application

First create the database
```bash
rake db:create
```
Migrate
```bash
rake db:migrate
```
Then import the games
```bash
rake games:import
```
or
```bash
rake db:seed
```

Authentication is required to use the site, so you need create an user via console:
```ruby
User.create(name: 'John Doe', email: 'john@test.com', password: '123123123', password_confirmation: '123123123', role: 'reviser')
```

You can change attributes in specific locales calling the method like this:
```ruby
attribute_locale
```
For example, change name in English(en)
```ruby
Game.first.name
=> "Jogo 1"
Game.first.update_attribute(:name_en, 'Game 1')
=> "Game 1"
```
Now if you change the actual locale
```ruby
I18n.locale = :en
```
It will return the name in English
```ruby
Game.first.name
=> "Game 1"
```
You can also call this way
```ruby
Game.first.name_en
=> "Game 1"
```
