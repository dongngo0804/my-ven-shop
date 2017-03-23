# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create!(name: "Blended")
Category.create!(name: "Beauty")
Category.create!(name: "Books")
Category.create!(name: "FashionMen")
Category.create!(name: "FashionWomen")
Category.create!(name: "Toys")



request = Vacuum.new

request.configure(
        aws_access_key_id: ENV["aws_access_key_id"],
        aws_secret_access_key: ENV["aws_secret_access_key"],
        associate_tag: ENV["associate_tag"]
      )

categories = Category.all

categories.each do |cate| 

params = {
	'SearchIndex' => 'Shoes',
			'Brand' => 'Lacoste',
			'Availability' => 'Available',
			'Keywords' => 'shirts',		
			'ResponseGroup' => 'ItemAttributes, Images'
}

raw_products = request.item_search(query: params)
hashed_products = raw_products.to_h

#binding.pry
@products = []

#flash[:now] = hashed_products['ItemSearchResponse']['Items']['Item'].length
	  hashed_products['ItemSearchResponse']['Items']['Item'].each do |item|
      #  binding.pry
      product = Product.new
      product.title = item['ItemAttributes']['Title']
      product.image_url = item['MediumImage']['URL']
      product.description = item['ItemAttributes']['Feature'].is_a?(Array) ?  item['ItemAttributes']['Feature'].join("\n") : item['ItemAttributes']['Feature']
      
      cate.products.create(product)      
    
end
end