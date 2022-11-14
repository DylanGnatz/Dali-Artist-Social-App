Rails.application.routes.draw do
  get 'profiles/index'
  get 'profiles/feed'
  get 'profiles/edit'
  put 'profiles/update'
  get '/profiles/:id', to: 'profiles#show', as: 'profiles'
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :chats
  resources :swipes
  resources :chats_messages
  resources :friends
  resources :artworks
  resources :events
  resources :profile_tags

  root :to => redirect('/profiles/index')
end
