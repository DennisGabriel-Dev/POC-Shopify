class ProductsController < ApplicationController
include ShopifyAuthenticate
  before_action :set_product, only: %i[ show edit update destroy ]
  # GET /products or /products.json
  def index
    @products = Product.all
    update_products
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  def update_products
    session = ShopifyAPI::Auth::Session.new(
      shop: Rails.application.credentials.shopify_configs[:shop_url],
      access_token: Rails.application.credentials.shopify_configs[:token]
    )
    client = ShopifyAPI::Clients::Rest::Admin.new(
      session: session
    )
    response = client.get(path: 'shop')

    p "================================"
=begin
          orders = client.get(
            path: 'orders',
            query: {
              "status": "any"
            },
          )
=end

          products = client.get(
            path: "products"
          )
          #p products.body["product"]
          #products.body

          products = products.body["products"]

          p "================================"
          for product in products
            product_exists = Product.find_by(name: product["title"])
            if product_exists&.name != product["title"]
              Product.create(name: product["title"],  html_body: product["body_html"], image: product["images"].last["src"])
          end
          end
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :price, :html_body, :image)
    end
end
