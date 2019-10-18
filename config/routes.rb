Rails.application.routes.draw do
  root 'home#index'
  devise_for :employees
  devise_for :candidates
  resources :candidates, only: %i[index show] do
    get 'dashboard', on: :collection
    get 'invites', to: 'candidates#invites', on: :collection
    post 'add-comment', to: 'candidates#add_comment', as: :add_comment
  end
  resources :positions, only: %i[new create show]
  resources :candidate_profiles, only: %i[new create edit update]
  resources :companies, only: %i[edit update show]
end
