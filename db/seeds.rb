# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Create role and admin user for site
puts "Creating admin role and user: test@example.com with passsword: password"
u = User.create(email: "test@example.com", password: "password", password_confirmation: "password", admin: true)
u.save
