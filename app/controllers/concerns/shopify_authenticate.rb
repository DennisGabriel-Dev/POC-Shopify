module ShopifyAuthenticate
  def set_authenticate
    @session = ShopifyAPI::Auth::Session.new(
      shop: Rails.application.credentials.shopify_configs[:shop_url],
      access_token: Rails.application.credentials.shopify_configs[:token]
    )
    @client = ShopifyAPI::Clients::Rest::Admin.new(
      session: session
    )
    @response = client.get(path: 'shop')
  end
end
