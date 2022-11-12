Rails.application.routes.draw do


  namespace :public do
    get 'customers/show'
    get 'customers/edit'
    get 'customers/unsubscribe'
  end
  namespace :public do
    get 'homes/top'
    root to: "homes#top"
    get '/homes/about', to: 'homes#about', as: "about"
  end

  namespace :admin do
    get 'homes/top'
    root to: "homes#top"

    resources :items, only: [:new, :show, :index, :edit, :create, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resource :orders, only: [:show]
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
