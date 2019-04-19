Rails.application.routes.draw do

  # root :to => 'welcome#index'
  get '/', to: 'welcome#index', as: 'root'

  post 'books/:book_id/reviews', to: 'reviews#create', as:'book_reviews'
  get '/books/:book_id/reviews/new', to: 'reviews#new', as: 'new_book_review'

    get '/books', to:'books#index'
    post '/books', to: 'books#create'


  get '/books/new', to: 'books#new', as: 'new_book'

  get '/book/:id', to: 'books#show', as:'book'
  delete '/book/:id', to: 'books#destroy'
  get '/reviews', to: 'reviews#index'
  delete '/reviews/:id', to: 'reviews#destroy', as:'review'
  get '/authors', to:'authors#index'
  get '/authors/:id', to: 'authors#show', as: 'author'
  delete '/authors/:id', to: 'authors#destroy'
    end
#
# Prefix Verb   URI Pattern                           Controller#Action
#   root GET    /                                     welcome#index
# book_reviews POST   /books/:book_id/reviews(.:format)     reviews#create
# new_book_review GET    /books/:book_id/reviews/new(.:format) reviews#new
#  books GET    /books(.:format)                      books#index
#        POST   /books(.:format)                      books#create
# new_book GET    /books/new(.:format)                  books#new
#   book GET    /books/:id(.:format)                  books#show
#        DELETE /books/:id(.:format)                  books#destroy
# author GET    /authors/:id(.:format)                authors#show
#        DELETE /authors/:id(.:format)                authors#destroy
# reviews GET    /reviews(.:format)                    reviews#index
# review DELETE /reviews/:id(.:format)                reviews#destroy
