class AddShopifyIdToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :id_shopify, :string
  end
end
