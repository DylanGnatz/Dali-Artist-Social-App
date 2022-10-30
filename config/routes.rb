Rails.application.routes.draw do
  get 'profiles/index'
  get 'profiles/edit'
  put 'profiles/update'
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :chats
  resources :swipes
  resources :chats_messages
  resources :friends

  devise_scope :user do
    authenticated :user do
      root 'profiles#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
