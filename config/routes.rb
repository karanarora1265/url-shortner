Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'links#new'
  resources :links, only: %i(create)
  get '/stats', to: 'links#stats'
  get '/:short_url', to: 'links#show'
end
