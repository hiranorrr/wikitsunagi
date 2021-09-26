Rails.application.routes.draw do
  # resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "questions/make_question" => "questions#make_question"
  get "scraping" => "questions#scraping"
  get "show/contents" => "questions#get_db"
  get "show/column/:name" => "questions#get_column_name"
end
