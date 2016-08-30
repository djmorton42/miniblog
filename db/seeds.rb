# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

general_category = Category.create(name: 'General')

Entry.create(title: 'This is my first blog entry', summary: 'The first blog I ever wrote', entry: 'This is a bunch of text', is_published: false, tags: '', category: general_category)
Entry.create(title: 'This is my second blog entry', summary: 'The second blog I ever wrote', entry: 'This is a bunch of text', is_published: false, tags: '', category: general_category)

User.create(email: 'user@example.com', name: 'Some User', password_hash: '$2a$10$3qyhvGbFtW6qK6B3aO/TnuopZ1XD/ZBP.iGT2GHuDRg0gjAAR/gK.')
