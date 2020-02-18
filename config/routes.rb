Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "user/registrations"}
  # This line mounts Solidus's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Solidus relies on it being the default of "spree"
  resources :users, only: [:show]
  resources :friendships

  resources :groups
  resources :group_members, only: [:create]

  resources :baskets
  resources :basket_members, only: [:create]

  resources :items
  resources :added_items, only: [:create]

  resources :user_items
  resources :user_items, only: [:create]

  get 'my_friends', to: "users#my_friends"
  get 'search_friends', to: "users#search"
  get 'items', to: "users#items"

  post 'add_friend', to: "users#add_friend"
  post 'remove', to: "groups#remove"
  post 'add', to: "groups#add"

  post 'remove_item', to: "baskets#remove_item"
  post 'remove_shopper', to: "baskets#remove_shopper"
  post 'add_shopper', to: "baskets#add_shopper"
  post 'add_item', to: "baskets#add_item"

  post 'show_basket', to: "items#show_basket"

  post 'show_user', to: "baskets#show_user"
  post 'share', to: "baskets#share"


  mount Spree::Core::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
