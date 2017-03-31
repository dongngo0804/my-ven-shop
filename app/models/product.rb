class Product < ApplicationRecord
  validates(:title, presence: true)
  validates(:price, length: { maximum: 10 })

  belongs_to :category, optional: true
  belongs_to :user, optional: true

  has_many :line_items

  mount_uploader :original_image_url, ImageUploader

  after_save :update_image_urls
  before_destroy :ensure_not_referenced_by_any_line_item

  searchable do
    text :title, :default_boost => 2
    text :description
  end

  private

  def update_image_urls
    # binding.pry
    unless original_image_url.url.nil?
      update_columns(
        large_image_url: original_image_url.large.url,
        medium_image_url: original_image_url.medium.url,
        small_image_url: original_image_url.small.url
      )
    end
  end

  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      error.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
