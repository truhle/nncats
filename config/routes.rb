Rails.application.routes.draw do

root "cats#index"
resources :cats
resources :cat_rental_requests do
  member do
    patch 'approve'
    patch 'deny'
  end
end

resource :session, only: [:new, :create, :destroy]
resources :users, only: [:new, :create] do
  resources :user_sessions, only: [:index, :destroy]
end


end
