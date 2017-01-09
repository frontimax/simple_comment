# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# default users
users = User.create!(
  [
    {
      name: 'admin',
      email: 'andreas.wenk@sumcumo.com',
      password: 'sumcumo',
      password_confirmation: 'sumcumo'
    },
    {
      name: 'user',
      email: 'info@joerg-kirschstein.de',
      password: 'sumcumo',
      password_confirmation: 'sumcumo'
    }
  ]
)

# default articles
articles = Article.create!(
  [
    {
      title: 'I am first!',
      content: 'I love to be the first in line and write articles about my workplace. ',
      user_id: users.first.id,
      parent_type: 'User',
      parent_id: users.first.id
    },
    {
      title: 'Well okay, im am second then...',
      content: 'Actually I am looking for a new workplace right now. Anybody know where to work next?',
      user_id: users.second.id,
      parent_type: 'User',
      parent_id: users.second.id
    }
  ]
)

# default comments
comments = Comment.create!(
  [
    {
      title: 'Beeing first is not everything :-)',
      content: '... but I salute you anyway.',
      user_id: users.second.id,
      parent_type: 'Article',
      parent_id: articles.first.id
    }
  ]
)

puts "seed finished!"
