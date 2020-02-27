Rails.application.routes.draw do

  # get '/cocktails', to: 'cocktails#index', as: 'cocktails'
  # get '/cocktails/new', to: 'cocktails#new', as: 'new_cocktail'
  # post '/cocktails', to: 'cocktails#create'
  # get '/cocktails/:id', to: 'cocktails#show', as: 'cocktail'

  # get 'cocktails/:id/doses/new', to: 'doses#new', as: 'new_dose'
  # post 'cocktails/:id/doses', to: 'doses#create'
  # delete '/doses/:id', to: 'doses#destroy'

  resources :cocktails, only: [:index, :new, :create, :show] do
    resources :doses, only: [:new, :create]
  end
  resources :doses, only: :destroy
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
