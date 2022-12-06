class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
  end

  def comfirm
    @order = Order.new(order_params)
    @order.payment_method = params[:order][:payment_method].to_i
    @order.shipping_cost = 800

    if params[:order][:address_number] == "1"
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name + current_customer.first_name
    end

    @cart_items = current_customer.cart_items.all
  end

  def create
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    #@order = current_customer.orders.new(order_params)
    @order.save!
    redirect_to public_orders_complete_path
    @cart_items.destroy_all

  end

  def complete
  end

  def index
    @orders = current_customer.orders.all

  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all

  end




  private

 def order_params
   params.require(:order).permit(:postal_code, :name, :address, :total_payment, :shipping_cost, :status, :customer_id)
 end

end
