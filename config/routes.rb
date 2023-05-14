Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :user, only: [:index] do
    get :record, on: :member
    get :sleep, on: :member
    get :wake_up, on: :member
    resource :follow_ship, only: [:index] do
      get 'show', to: 'follow_ship#show', on: :member
      get 'follow/:follow_id', to: 'follow_ship#follow', on: :member
    end
  end
end
