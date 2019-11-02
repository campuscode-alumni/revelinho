Rails.application.routes.draw do
  devise_for :employees
  devise_for :candidates

  root to: 'home#index'

  resources :companies, only: %i[index edit update show] do
    collection do
      get 'dashboard'
      get 'invites'
      get 'selection_processes'
    end
  end
  resources :company_profiles, only: %i[new create edit update]
  resources :candidates, only: %i[index show] do
    member do
      post 'add-comment', to: 'candidates#add_comment', as: :add_comment
      post 'invite', to: 'candidates#invite'
      post 'invites/accept/:id', to: 'candidates#accept_invite', as: :accept_invites
      post 'invites/reject/:id', to: 'candidates#reject_invite', as: :reject_invites
    end

    collection do
      get 'dashboard'
      get 'invites'
      get 'offers'
    end

    get 'invites/select_process/:id', to: 'selection_processes#show', on: :collection, as: :selection_process
    post 'invites/select_process/:id', to: 'selection_processes#send_message', on: :collection, as: :send_message

    post 'interviews/accept/:id', to: 'interviews#accept', on: :member, as: :accept_interview
    post 'interviews/reject/:id', to: 'interviews#reject', on: :member, as: :reject_interview
    
    resources :offers, only: %i[new create], path: 'invites/selection_process/:selection_process_id/offers'
  end
  
  resources :selection_processes, only: %i[show] do
    post 'selection_process/:id', to: 'selection_processes#send_message', as: :send_message
    resources :interviews, only: %i[index new create]
  end

  resources :positions, only: %i[new create show]
  resources :candidate_profiles, only: %i[new create edit update]

  get 'my_company', to: 'company#my_company'
end
