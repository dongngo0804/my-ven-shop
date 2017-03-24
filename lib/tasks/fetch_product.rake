require 'amazon/product_fetcher'
require 'amazon/category_creator'

desc 'Fetch products from amazon'
namespace :amazon do
  task fetch_product: :environment do
    ::ProductFetcher.new(Category.all).call
  end

  task create_category: :environment do
	categories = ['Baby','Beauty','Books',
				  'FashionWomen','FashionMen',
				  'Toys']
	::CategoryCreator.new(categories)
  end

end