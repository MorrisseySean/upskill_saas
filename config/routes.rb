Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :users do 
    resource :profile
  end
  resources :freelancers do
    resource :ability
  end
  resources :teams
  get 'about', to: 'pages#about'
  get 'admin', to: 'pages#admin'
  get 'ppl', to: 'pages#leaguesignup'
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
end