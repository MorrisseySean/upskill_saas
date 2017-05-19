Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :users do 
    resource :profile
    resources :messages
  end
  
  resources :freelancers do
    resource :ability
  end
  
  resources :teams
  resources :matches
  resources :admin
  resources :events
  
  get 'about', to: 'pages#about'
  get 'ppl', to: 'pages#leaguesignup'
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
end