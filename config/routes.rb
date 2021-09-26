Rails.application.routes.draw do
  # resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "questions/make_question" => "posts#make_question"
  get "questions/scraping" => "posts#scraping"
  get "questions/show/contents" => "posts#get_db"
  get "questions/show/column/:name" => "posts#get_column_name"
end
