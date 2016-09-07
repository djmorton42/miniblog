if Rails.env == 'production'
  general_category = Category.create(name: 'General')
  User.new(email: 'user@example.com', name: 'Some User', password_hash: '$2a$10$3qyhvGbFtW6qK6B3aO/TnuopZ1XD/ZBP.iGT2GHuDRg0gjAAR/gK.').save(validate: false)
elsif Rails.env == 'development'
  general_category = Category.create(name: 'General')

  Setting.create(blog_title: 'The Blog', blog_subtitle: 'A blog aboug stuff and things', display_bio: false, bio: '')

  Entry.create(title: 'This is my first blog entry', summary: 'The first blog I ever wrote', entry: 'This is a bunch of text', is_published: false, tags: '', category: general_category)
  Entry.create(title: 'This is my second blog entry', summary: 'The second blog I ever wrote', entry: 'This is a bunch of text', is_published: false, tags: '', category: general_category)

  User.new(email: 'user@example.com', name: 'Some User', password_hash: '$2a$10$3qyhvGbFtW6qK6B3aO/TnuopZ1XD/ZBP.iGT2GHuDRg0gjAAR/gK.').save(validate: false)
end
