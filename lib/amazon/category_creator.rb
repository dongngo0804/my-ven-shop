class CategoryCreator
  def initialize(categories)
    categories.each do |cate|
      Category.create!(name: cate)
    end
  end
end
