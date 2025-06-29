Rails.application.routes.draw do
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

      resources :courses, only: [:index]
      resources :students, only: [:index]
      resources :posts, only: [:index]
      resources :enquiries, only: [:create]
    end
  end

  devise_for :members
  resources :courses
  resources :students
  resources :posts
  resources :enquiries, only: [:index, :show]
  get "/up", to: "health#up"

  root "home#index"
end
