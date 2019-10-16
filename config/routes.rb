Rails.application.routes.draw do
  devise_for :employees
  devise_for :candidates

  root to: 'home#index'

  resources :companies, only: %i[edit update show]
  resources :candidates, only: %i[index show] do
    post 'add-comment', to: 'candidates#add_comment', as: :add_comment
  end
  resources :positions
end
