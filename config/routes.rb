Rails.application.routes.draw do
  devise_for :employees
  devise_for :candidates

  root to: 'home#index'

  resources :companies, only: %i[edit update show]
  resources :candidates, only: %i[index show]
  resources :positions  
end
