class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = 0
  end

  def create
    @cart_item = current_customer.cart_items.build(cart_item_params)
    @cart_items = CartItem.where(customer_id: current_customer.id)

    @cart_item.save!

    redirect_to public_cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to public_cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to public_cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to public_cart_items_path
  end

  private
    def cart_item_params
     params.require(:cart_item).permit(:amount, :item_id, :customer_id)
    end

end
