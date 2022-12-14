Rails.application.routes.draw do
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
   sessions: "admin/sessions"
  }

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
   registrations: "public/registrations",
   sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  scope module: :public do
    get 'homes/top'
    root to: "homes#top"
    get '/about', to: 'homes#about', as: "about"
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'

    get 'orders/complete' => 'orders#complete'
    resources :customers, only: [:show, :edit, :update]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy,]
    resources :orders, only: [:new, :create, :index, :show, :complete]
    post 'orders/comfirm' => 'orders#comfirm'
    get 'unsubscribe/:id' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    patch ':id/withdraw/:id' => 'customers#withdraw', as: 'withdraw_customer'
    put 'withdraw/:id' => 'customers#withdraw'


  end

  namespace :admin do
    get 'homes/top'
    root to: "homes#top"

    resources :items, only: [:new, :show, :index, :edit, :create, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]

  end

end
