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

  root :to => redirect('/profiles/index')
end
