class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :status, default: 0
      t.decimal :total_price, :default => 0, :precision => 15, :scale => 2 

      t.timestamps
    end
  end
end
