# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
   before_action :reject_inactive_customerr, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  def reject_inactive_customer
    @customer = Customer.find_by(last_name: params[:customer][:last_name], first_name: params[:customer][:first_name])
    if @customer
      if @customer.valid_password?(params[:customer][:encrypted_password]) && !@customer.is_deleted
        redirect_to new_customer_session_path
      end
    end
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
