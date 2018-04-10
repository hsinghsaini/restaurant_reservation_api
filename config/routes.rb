Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :restaurants do
    resources :shifts
    resources :tables
    resources :reservations, except: [:index]
    member do
      get 'reservations'
    end
  end
end
