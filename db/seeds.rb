# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Entry.create(title: 'This is my first blog entry', summary: 'The first blog I ever wrote', entry: 'This is a bunch of text', is_published: false, tags: '')
Entry.create(title: 'This is my second blog entry', summary: 'The second blog I ever wrote', entry: 'This is a bunch of text', is_published: false, tags: '')
