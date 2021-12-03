Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/directors', to: 'directors#index'
  get '/directors/:id', to: 'directors#show'
  
  get '/films', to: 'films#index'
  get '/films/:id', to: 'films#show'

  get '/galleries', to: 'galleries#index'
  get 'galleries/:id', to: 'galleries#show'
  get '/pieces', to: 'pieces#index'
end
