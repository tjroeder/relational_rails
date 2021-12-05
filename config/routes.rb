Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/directors', to: 'directors#index'
  get '/directors/new', to: 'directors#new'
  get '/directors/:id', to: 'directors#show'
  get '/directors/:id/edit', to: 'directors#edit'
  get '/directors/:director_id/films', to: 'director_films#index'
  post '/directors', to: 'directors#create'
  patch '/directors/:id', to: 'directors#update'

  get '/films', to: 'films#index'
  get '/films/:id', to: 'films#show'

  get '/galleries', to: 'galleries#index'
  get '/galleries/:id', to: 'galleries#show'
  get '/galleries/:gallery_id/pieces', to: 'gallery_pieces#index'

  get '/pieces', to: 'pieces#index'
  get '/pieces/:id', to: 'pieces#show'
end
