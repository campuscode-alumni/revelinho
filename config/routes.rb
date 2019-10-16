Rails.application.routes.draw do
  devise_for :employees
  devise_for :candidates
  resources :candidates, only: %i[index show] do
    get 'dashboard', on: :collection
  end
  root 'home#index'
  resources :positions, only: %i[new create show]
  resources :candidate_profiles, only: %i[new create edit update]
end
