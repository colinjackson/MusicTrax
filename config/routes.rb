MusicTrax::Application.routes.draw do
  resources :sign_ins, only: [:new, :create, :destroy]
  
  resources :users, only: [:index, :new, :create, :show, :destroy] do
    collection do
      get 'activations' => 'users#activate'
    end
    member do
      patch 'toggle_admin' => 'users#toggle_admin'
    end
  end
  
  resources :bands do
    member { resources :albums, only: :new }
  end
  
  resources :albums, only: [:create, :show, :edit, :update, :destroy] do
    member { resources :tracks, only: :new }
  end
  
  resources :tracks, only: [:create, :show, :edit, :update, :destroy]
  
  post '/notes' => 'tracks#create_note'
  delete '/notes/:id' => 'tracks#destroy_note', as: 'note'
  
  root to: 'sign_ins#new'
end
