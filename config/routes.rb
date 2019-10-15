Rails.application.routes.draw do
  devise_for :employees
  devise_for :candidates
  resources :candidates, only: %i[index show]
  root 'home#index'
  resources :positions, only: %i[new create show]
end
