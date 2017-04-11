class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :original_image_url
      t.string :large_image_url
      t.string :medium_image_url
      t.string :small_image_url
      t.decimal :price

      t.timestamps
    end
  end
end
