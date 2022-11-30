Rails.application.routes.draw do
  resources :collectives
  get '/collectives/:id/artwork', to: 'collective_artworks#new', as: 'new_collective_artworks'
  post '/collectives/:id/artwork', to: 'collective_artworks#create', as: 'create_collective_artworks'
  delete '/collectives/:id/artwork/:artId', to: 'collective_artworks#destroy', as: 'delete_collective_artworks'
  delete '/collectives/:id/member/:memberId', to: 'collectives_profiles#destroy', as: 'delete_collective_profiles'
  post '/collectives/:id/members/add', to: 'collectives_profiles#add', as: 'add_collective_profiles'
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
