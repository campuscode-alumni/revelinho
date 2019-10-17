Rails.application.routes.draw do
  devise_for :employees
  devise_for :candidates

  root to: 'home#index'

  resources :companies, only: %i[index edit update show]
  resources :company_profiles, only: %i[new create]
  resources :candidates, only: %i[index show]
  resources :positions
end
