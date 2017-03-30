class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :status, default: 'new'
      t.decimal :total_price, default: 0

      t.timestamps
    end
  end
end
