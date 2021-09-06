Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "questions/make_question" => "questions#make_question"
  get "test" => "questions#test"
  # get "register" => "questions#register"
  get "get/:category" => "questions#get_db"
end
