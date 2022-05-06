# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.delete_all()
Role.create([
  {title: "ally", description: ""},
  {title: "channel_admin", description: ""},
  {title: "depot_admin", description: ""},
  {title: "channel_depot_admin", description: ""}
])

Product.delete_all()
30.times do
  name = Faker::Commerce.product_name
  brand = Faker::Commerce.brand
  sku =  Faker::Barcode.isbn

  Product.create(name: name, brand: brand, sku: sku)
end
