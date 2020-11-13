Rails.application.routes.draw do
  get 'signup' => 'users#new', defaults: { format: :json }
  resources :users, only: [:index, :show, :create, :edit, :update], defaults: { format: :json }
  resources :user_token, only: [:create], defaults: { format: :json }
end
