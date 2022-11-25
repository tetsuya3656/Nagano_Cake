Rails.application.routes.draw do



  namespace :public do
    get 'homes/top'
    root to: "homes#top"
    get '/about', to: 'homes#about', as: "about"
    resources :customers, only: [:show, :edit, :unsubscribe]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create]
    get 'unsubscribe/:name' => 'customerss#unsubscribe', as: 'confirm_unsubscribe'
    patch ':id/withdraw/:name' => 'customers#withdraw', as: 'withdraw_customer'
    put 'withdraw/:name' => 'customers#withdraw'
  end

  namespace :admin do
    get 'homes/top'
    root to: "homes#top"

    resources :items, only: [:new, :show, :index, :edit, :create, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show]

  end
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
end
