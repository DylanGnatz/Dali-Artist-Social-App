Rails.application.routes.draw do
  resources :collectives
  get 'profiles/index'
  get 'profiles/show'
  get 'profiles/feed'
  get 'profiles/edit'
  put 'profiles/update'
  put 'profile_tags/update'
  get '/profiles/:id', to: 'profiles#show', as: 'profiles'
  get "/location" => "profiles#location"
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
