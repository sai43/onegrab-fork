Rails.application.routes.draw do
  # This file is part of OneGrab.
  # OneGrab is an open-source project for managing online courses and subscriptions.  
  # All rights reserved.
  # For more information, visit: https://onegrab.dev  
  # Author: Saich
  # License: MIT License
  # API routes

  namespace :api do
    namespace :v1 do
      devise_for :users,
                 skip: [:new, :edit],
                 controllers: {
                     sessions: 'api/v1/users/sessions',
                     registrations: 'api/v1/users/registrations',
                     confirmations: 'api/v1/users/confirmations'
                 },
                 path_names: {
                     sign_in: 'login',
                     sign_out: 'logout',
                     sign_up: 'signup'
                 },
                 defaults: { format: :json }

      resources :courses, only: [:index] do 
        member do
          post :enroll
        end
      end
      resources :students, only: [:index]
      resources :posts, only: [:index]
      resources :enquiries, only: [:create]
      resources :plans, only: [:index]
      resources :enrollments, only: [:index, :show, :create, :update] do
        collection do
          post :bulk_create
        end
      end
      resource :subscription, only: [:show, :create] do
        post :cancel, on: :collection
      end
    end
  end


  # This file is part of OneGrab.
  # OneGrab is an open-source project for managing online courses and subscriptions.
  # For more information, visit: https://onegrab.dev
  # Admin routes
  resources :courses do
    member do
      post :enroll
    end
  end

  resources :subscriptions do
    member do
      patch :confirm
    end
  end

  devise_for :members
  resources :posts
  resources :enrollments
  resources :enquiries, only: [:index, :show]
  resources :students
  get "/up", to: "health#up"

  root "home#index"
end
