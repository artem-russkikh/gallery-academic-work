Rails.application.routes.draw do
  resources :painting_kinds
  resources :ranks
  root to: 'ranks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
