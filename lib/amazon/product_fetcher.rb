class ProductFetcher
  attr_reader :categories, :connector

  def initialize(categories)
    @categories = Array(categories)
    @connector = create_request
  end

  def call

    categories.each do |cate|
      params = {
      'SearchIndex' => cate.name,
      'Availability' => 'Available',
      'Condition' => 'All',
      'Title' => 'a',
      'ResponseGroup' => 'ItemAttributes, Images'
      }

      raw_products = connector.item_search(query: params)
      hashed_products = raw_products.to_h

      # binding.pry
      products = []

      hashed_products['ItemSearchResponse']['Items']['Item'].each do |item|
        #  binding.pry
        product = {}
        product['title'] = item['ItemAttributes']['Title']
        product['image_url'] = item['MediumImage']['URL']
        product['description'] = item['ItemAttributes']['Feature'].is_a?(Array) ? item['ItemAttributes']['Feature'].join("\n") : item['ItemAttributes']['Feature']
        product['sales'] = 0
        product['price'] = item['ItemAttributes']['ListPrice']['Amount'] unless item['ItemAttributes']['ListPrice'] == nil
          
        
        
        cate.products.create!(product)
      end
    end
  end

  private

  def create_request
    request = Vacuum.new

    request.configure(
      aws_access_key_id: ENV['aws_access_key_id'],
      aws_secret_access_key: ENV['aws_secret_access_key'],
      associate_tag: ENV['associate_tag']
    )
    request
  end
end