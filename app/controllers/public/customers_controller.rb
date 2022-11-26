class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])

  end

  def edit
    @customer = Customer.find(params[:id])

  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to public_customer_path
  end

  def unsubscribe
    @customer = Customer.find_by(last_name: params[:last_name], first_name: params[:first_name])
  end

  def withdraw
    @customer = Customer.find_by(last_name: params[:last_name], first_name: params[:first_name])
    @Customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_deleted, :encrypted_password)
  end

end
