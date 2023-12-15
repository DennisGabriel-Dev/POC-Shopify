class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.decimal :total_price
      t.string :destiny
      t.string :customer_address
      t.string :shipping_address

      t.timestamps
    end
  end
end
