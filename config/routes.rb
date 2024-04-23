Rails.application.routes.draw do
  resources :affiliations
  resources :locations
  resources :people
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post '/people/import_person_csv'     => 'people#import_person_csv'
  get  '/people/count_all'             => 'people#count_all'

  # Defines the root path route ("/")
  # root "articles#index"
end
