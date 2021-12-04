Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/directors', to: 'directors#index'
  get '/directors/:id', to: 'directors#show'
  get '/directors/:director_id/films', to: 'director_films#index'

  get '/films', to: 'films#index'
  get '/films/:id', to: 'films#show'

  get '/galleries', to: 'galleries#index'
  get '/galleries/new', to: 'galleries#new'
  get '/galleries/:id', to: 'galleries#show'
  get '/galleries/:id/edit', to:'galleries#edit'
  post '/galleries', to: 'galleries#create'
  patch '/galleries/:id', to: 'galleries#update'

  get '/galleries/:gallery_id/pieces', to: 'gallery_pieces#index'
  get 'galleries/:gallery_id/pieces/new', to: 'gallery_pieces#new'
  post '/galleries/:gallery_id/pieces', to: 'gallery_pieces#create'

  get '/pieces', to: 'pieces#index'
  get '/pieces/:id', to: 'pieces#show'
  get '/pieces/:id/edit', to: 'pieces#edit'
  patch '/pieces/:id', to: 'pieces#update'
end
