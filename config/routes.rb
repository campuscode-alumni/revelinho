Rails.application.routes.draw do
  devise_for :employees
  devise_for :candidates
  
  root to: 'home#index'
end
