Rails.application.routes.draw do
  root 'blog#index'
  
  post 'entries/:entry_id/comments' => 'entries#add_comment'

  #Must come before resources :images below
  get 'images/banner' => 'images#banner'
  get 'category/:name' => 'categories#show'
  get 'feed' => 'blog#feed', only: [:show], defaults: { format: 'rss' }

  resources :entries, only: [:show]
  resources :images, only: [:show]
  resource :sitemap, only: [:show], defaults: { format: 'json' }

  ADMIN_PROTOCOL = (Rails.env.production? ? "https" : "http")

  namespace :admin do
    root to: 'admin#index', protocol: ADMIN_PROTOCOL
    resource :authentications, only: [:create, :new, :destroy], protocol: ADMIN_PROTOCOL
    resource :settings, only: [:show, :update], protocol: ADMIN_PROTOCOL
    resources :entries, only: [:create, :new, :edit, :update, :show, :destroy, :index], protocol: ADMIN_PROTOCOL do
      resources :history, only: [:index, :show], protocol: ADMIN_PROTOCOL
      
      post 'history/:id/restore' => 'history#restore', protocol: ADMIN_PROTOCOL
    end
    resources :categories, only: [:create, :new, :edit, :update, :show, :index], protocol: ADMIN_PROTOCOL
    resources :images, only: [:create, :new, :show, :destroy, :index], protocol: ADMIN_PROTOCOL
    resources :users, only: [:create, :new, :edit, :update, :show, :index], protocol: ADMIN_PROTOCOL
    resources :test_email, only: [:create], protocol: ADMIN_PROTOCOL

    post 'entries/:id/publish' => 'entries#publish', protocol: ADMIN_PROTOCOL
    post 'entries/:id/unpublish' => 'entries#unpublish', protocol: ADMIN_PROTOCOL

    post 'images/banner' => 'images#set_banner', protocol: ADMIN_PROTOCOL
    post 'images/:id/publish' => 'images#publish', protocol: ADMIN_PROTOCOL
    post 'images/:id/unpublish' => 'images#unpublish', protocol: ADMIN_PROTOCOL

    delete 'comments/:id' => 'comments#delete', protocol: ADMIN_PROTOCOL
    put 'comments/:id/approve' => 'comments#approve', protocol: ADMIN_PROTOCOL
    put 'comments/:id/unapprove' => 'comments#unapprove', protocol: ADMIN_PROTOCOL

  end
end
