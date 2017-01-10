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
      password_confirmation: 'sumcumo',
      admin_role: true,
      country: 'Germany'
    },
    {
      name: 'user',
      email: 'info@joerg-kirschstein.de',
      password: 'sumcumo',
      password_confirmation: 'sumcumo',
      country: 'Germany'
    },
    {
      name: 'max',
      email: 'max@online.de',
      password: 'sumcumo',
      password_confirmation: 'sumcumo',
      country: 'Germany'
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
    },
    {
      title: 'Ronaldo ist Weltfußballer des Jahres',
      content: 'Cristiano Ronaldo ist zum zweiten Mal innerhalb kurzer Zeit als bester Fußballer des Jahres 2016 ausgezeichnet worden. Nach seinem Triumph bei der Ballon-d Or-Wahl im Dezember wurde der 31 Jahre alte Portugiese nun auch von der Fifa zum Weltfußballer gekürt. Ronaldo setzte sich dabei gegen Dauerrivale Lionel Messi aus Argentinien und den Franzosen Antoine Griezmann durch. Hintergrund der zwei Wahlen ist ein Streit zwischen der Fifa und dem französischen Magazin "France Football", dem die Marke Ballon dOr gehört. Deshalb werden nach sechsjähriger Zusammenarbeit nun zwei Auszeichnungen vergeben. Neu ist dabei, dass neben Journalisten, Kapitänen und Trainern der Nationalmannschaften auch Fans mit abstimmen durften.',
      user_id: User.where(name: 'max').first.id,
      parent_type: 'User',
      parent_id: User.where(name: 'max').first.id
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
    },
    {
      title: 'I really like your workplace!',
      content: 'Maybe we should meet again?',
      user_id: User.where(name: 'max').first.id,
      parent_type: 'Article',
      parent_id: articles.first.id
    }
  ]
)

puts "seed finished!"
