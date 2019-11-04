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
      post 'interviews/accept/:id', to: 'interviews#accept', as: :accept_interview
      post 'interviews/reject/:id', to: 'interviews#reject', as: :reject_interview
      post 'interviews/status/:id', to: 'interviews#status', as: :set_interview_status
    end

    collection do
      get 'dashboard'
      get 'invites'
      get 'invites/select_process/:id', to: 'selection_processes#show', as: :selection_process
      get 'invites/interviews/:id', to: 'interviews#show', as: :interview
      get 'invites/interviews/:id/feedbacks', to: 'interview_feedbacks#index', as: :interview_feedback
      post 'invites/select_process/:id', to: 'selection_processes#send_message', as: :send_message
      post 'invites/interviews/:id/feedbacks', to: 'interview_feedbacks#send_feedback', as: :send_feedback
      get 'offers'
      get 'my-profile'
    end

    resources :offers, only: %i[new create show], path: 'invites/selection_process/:selection_process_id/offers' do
      post 'accept', on: :member
      post 'reject', on: :member
    end
  end
  
  resources :selection_processes, only: %i[show] do
    post 'selection_process/:id', to: 'selection_processes#send_message', as: :send_message
    resources :interviews, only: %i[index new create update]
  end

  resources :positions, only: %i[index new create]
  resources :candidate_profiles, only: %i[new create edit update]

  get 'my_company', to: 'company#my_company'
end
