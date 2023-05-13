Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :user, only: [:index] do
    get :record, on: :member
  end
end
