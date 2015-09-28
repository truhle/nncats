Rails.application.routes.draw do

  resources :cat_rental_requests
root "cats#index" 
resources :cats

end
