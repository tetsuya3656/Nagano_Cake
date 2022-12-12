class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = 0
  end

  def create
    @new_cart_item = current_customer.cart_items.build(cart_item_params)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @cart_item = @cart_items.find_by(item_id: @new_cart_item.item.id)
    if @cart_item
      @cart_item.update(amount: @new_cart_item.amount + @cart_item.amount)
    else
      @new_cart_item.save
    end
    redirect_to cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private
    def cart_item_params
     params.require(:cart_item).permit(:amount, :item_id, :customer_id)
    end

end
