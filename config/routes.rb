MusicTrax::Application.routes.draw do
  resources :sign_ins, only: [:new, :create, :destroy]
  
  resources :users, only: [:new, :create, :show]
end
