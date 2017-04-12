class Product < ApplicationRecord
  
   searchable do
     text :title
   end

  paginates_per 9

  validates :title, presence: true, length: {maximum: 150}
  validates :description, presence: true, length: {maximum: 1500}
  validates :stock, numericality: true, presence: true
  validate :picture_size


  belongs_to :category, optional: true
  belongs_to :user, optional: true

  has_many :line_items

  mount_uploader :original_image_url, ImageUploader

  after_save :update_image_urls
  before_destroy :ensure_not_referenced_by_any_line_item

  

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

  def picture_size
    if original_image_url.size > 1.megabytes
      errors.add(:original_image, "should be less than 1MB")
    end
  end


end
