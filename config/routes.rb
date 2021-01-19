Rails.application.routes.draw do
  devise_for :users, :controllers => { 
     sessions: 'users/sessions',  
     registrations: 'users/registrations'}

  root to: "countries#index"

  resources :countries
end
