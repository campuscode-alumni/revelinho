Rails.application.routes.draw do
  devise_for :employees
  devise_for :candidates
  root to: 'candidates#index'
  resources :candidates, only: %i[index show]
end
