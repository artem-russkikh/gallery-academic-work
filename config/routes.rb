Rails.application.routes.draw do
  resources :dispositions
  resources :rooms
  resources :paintings do
    get :autocomplete_user_email, on: :collection
    get :autocomplete_painting_kind_title, on: :collection
  end
  resources :users do
    get :autocomplete_rank_title, on: :collection
  end
  resources :painting_kinds
  resources :ranks

  root to: 'ranks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
