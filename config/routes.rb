Rails.application.routes.draw do
  get 'sessions/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

 # root '/login', to: 'sessions#new'

  get 'pronosticos/new/:id' => 'pronosticos#new'
  
  get 'usuarios/:id/pronosticos/:jornada' => 'pronosticos#cargar'

  get 'resultados/new/:id' => 'resultados#new'

  get 'resultados/:id' => 'resultados#show'

  get 'usuarios/:id' => 'usuarios#show'

  #get    '/signup',  to: 'usuarios#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'


  #get 'usuarios/' => 'usuarios#index'

  resources :pronosticos
  resources :resultados
	resources :home
  #resources :juegos
end
