json.extract! order, :id, :total_price, :destiny, :customer_address, :shipping_address, :created_at, :updated_at
json.url order_url(order, format: :json)
