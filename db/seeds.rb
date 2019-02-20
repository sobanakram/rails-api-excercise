# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

a1 = Address.create(street: 'Street no 1,', city: 'New York', zip_code: '23412')
a2 = Address.create(street: 'Hors road,', city: 'California', zip_code: '13234')
a3 = Address.create(street: 'Another road', city: 'Saint jhons', zip_code: '95434')

Customer.create(name: 'James', address: a1)
Customer.create(name: 'Keith', address: a2)
Customer.create(name: 'Jones', address: a3)