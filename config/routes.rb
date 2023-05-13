Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :user, only: [:index] do
    get :record, on: :member
    get :sleep, on: :member
    get :wake_up, on: :member
  end
end
