json.extract! product, :id, :name, :price, :html_body, :image, :created_at, :updated_at
json.url product_url(product, format: :json)
