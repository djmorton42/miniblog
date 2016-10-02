Rails.application.routes.draw do
  root 'blog#index'

  resources :entries, only: [:show]
  resources :images, only: [:show]

  post 'entries/:entry_id/comments' => 'entries#add_comment'

  get 'images/banner' => 'images#banner'
  get 'category/:name' => 'categories#show'

  ADMIN_PROTOCOL = (Rails.env.production? ? "https" : "http")

  namespace :admin do
    root to: 'admin#index', protocol: ADMIN_PROTOCOL
    resource :authentications, only: [:create, :new, :destroy], protocol: ADMIN_PROTOCOL
    resource :settings, only: [:show, :update], protocol: ADMIN_PROTOCOL
    resources :entries, only: [:create, :new, :edit, :update, :show, :destroy, :index], protocol: ADMIN_PROTOCOL
    resources :categories, only: [:create, :new, :edit, :update, :show, :index], protocol: ADMIN_PROTOCOL
    resources :images, only: [:create, :new, :show, :destroy, :index], protocol: ADMIN_PROTOCOL
    resources :users, only: [:create, :new, :edit, :update, :show, :index], protocol: ADMIN_PROTOCOL

    post 'entries/:id/publish' => 'entries#publish', protocol: ADMIN_PROTOCOL
    post 'entries/:id/unpublish' => 'entries#unpublish', protocol: ADMIN_PROTOCOL

    post 'images/banner' => 'images#set_banner', protocol: ADMIN_PROTOCOL
    post 'images/:id/publish' => 'images#publish', protocol: ADMIN_PROTOCOL
    post 'images/:id/unpublish' => 'images#unpublish', protocol: ADMIN_PROTOCOL
  end
end
