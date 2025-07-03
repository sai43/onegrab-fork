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

      resources :my_courses, only: [:index, :show], controller: "my_courses" do
        resources :sections, only: [:show], controller: "course_sections"
      end

      resources :topics, only: [:update]

      resources :courses, only: [:index, :show] do
        member do
          post :enroll
        end

        resources :sections, only: [:index, :show]
      end

      resources :sections, only: [] do
        resources :lessons, only: [:index, :show]
      end

      resources :lessons, only: [] do
        resources :topics, only: [:index, :show]
      end

      resources :students, only: [:index]
      resources :posts, only: [:index]
      resources :enquiries, only: [:create]
      resources :plans, only: [:index]

      resources :enrollments, only: [:index, :show, :create, :update] do
        collection do
          post :bulk_create
        end

        member do
          get :progress
        end
      end

      resource :subscription, only: [:show, :create] do
        post :cancel, on: :collection
      end

      resources :lesson_progresses, only: [:update]
    end
  end

  # Web routes
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
  get "/redis_up", to: "health#redis_up"

  #Admin namespace
  namespace :admin do
    get 'dashboard', to: 'dashboard#index', as: :dashboard

    resources :courses, shallow: true do
      resources :sections
    end

    resources :sections, shallow: true do
      resources :lessons
    end

    resources :lessons, shallow: true do
      resources :topics
    end   

    resources :comments, only: [:index, :destroy] do
      collection do
        get :pending
        get :approved
      end

      member do
        patch :approve
        patch :hide
      end
    end    
  end

  root "home#index"
end
