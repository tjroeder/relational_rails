Rails.application.routes.draw do

  get '/', to: 'welcome#index'

  get '/directors', to: 'directors#index'
  get '/directors/new', to: 'directors#new'
  get '/directors/:id', to: 'directors#show'
  get '/directors/:id/edit', to: 'directors#edit'
  get '/directors/:director_id/films', to: 'director_films#index'
  get '/directors/:director_id/films/new', to: 'director_films#new'
  post '/directors', to: 'directors#create'
  post '/directors/:director_id/films', to: 'director_films#create'
  patch '/directors/:id', to: 'directors#update'
  delete '/directors/:id', to: 'directors#destroy'

  get '/films', to: 'films#index'
  get '/films/:id', to: 'films#show'
  get '/films/:id/edit', to: 'films#edit'
  patch '/films/:id', to: 'films#update'
  delete '/films/:id', to: 'films#destroy'

  get '/galleries', to: 'galleries#index'
  get '/galleries/new', to: 'galleries#new'
  get '/galleries/:id', to: 'galleries#show'
  get '/galleries/:id/edit', to:'galleries#edit'
  post '/galleries', to: 'galleries#create'
  patch '/galleries/:id', to: 'galleries#update'
  delete 'galleries/:id', to: 'galleries#delete'

  get '/galleries/:gallery_id/pieces', to: 'gallery_pieces#index'
  get 'galleries/:gallery_id/pieces/new', to: 'gallery_pieces#new'
  post '/galleries/:gallery_id/pieces', to: 'gallery_pieces#create'

  get '/pieces', to: 'pieces#index'
  get '/pieces/:id', to: 'pieces#show'
  get '/pieces/:id/edit', to: 'pieces#edit'
  patch '/pieces/:id', to: 'pieces#update'
  delete '/pieces/:id', to: 'pieces#delete'
end
