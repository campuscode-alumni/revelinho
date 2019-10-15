Rails.application.routes.draw do
  devise_for :employees, controllers: { registrations: 'employees/registrations' }
  devise_for :candidates
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  resources :companies, only: %i[edit update]
  resources :candidates, only: [:show] do
    post 'add-comment', to: 'candidates#add_comment', as: :add_comment
  end
end
