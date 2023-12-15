class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  def update_order
    import_orders
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def import_orders
      session = ShopifyAPI::Auth::Session.new(
        shop: Rails.application.credentials.shopify_configs[:shop_url],
        access_token: Rails.application.credentials.shopify_configs[:token]
      )
      client = ShopifyAPI::Clients::Rest::Admin.new(
        session: session
      )
      response = client.get(path: 'shop')
      orders = client.get(
          path: 'orders',
          query: {
            "status": "any"
          },
        )
        orders = orders.body["orders"]
        for order in orders
          address = order["billing_address"]
          address = "Enderço: #{address["address1"]}", "Cidade #{address["city"]}", "CEP: #{address["zip"]}" , "Country: #{address["country"]}", "Province: #{address["province"]}"

          unless Order.find_by(id_shopify: order["id"])
            Order.create(id_shopify: order["id"], total_price: order["current_total_price"], email_contact: order["contact_email"], number: order["number"], shipping_address: address)
          end
        end

        redirect_to orders_path , notice: "Orders atualizados"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:total_price, :destiny, :customer_address, :shipping_address)
    end
end
