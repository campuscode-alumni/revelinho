Rails.application.routes.draw do
  devise_for :employees
  devise_for :candidates

  root to: 'home#index'

  resources :companies, only: %i[index edit update show] do
    get 'dashboard', on: :collection
  end
  resources :company_profiles, only: %i[new create]
  resources :candidates, only: %i[index show] do
    get 'dashboard', on: :collection
    post 'add-comment', to: 'candidates#add_comment', as: :add_comment
  end
  resources :positions, only: %i[new create show]
  resources :candidate_profiles, only: %i[new create edit update]

  get 'my_company', to: 'company#my_company'
end
