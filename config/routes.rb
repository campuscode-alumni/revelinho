Rails.application.routes.draw do
  devise_for :employees
  devise_for :candidates

  root to: 'home#index'

  resources :companies, only: %i[index edit update show]
  resources :company_profiles, only: %i[new create]
  resources :candidates, only: %i[index show] do
    get 'dashboard', on: :collection
  end
  resources :positions, only: %i[new create show]
  resources :candidate_profiles, only: %i[new create edit update]
end
