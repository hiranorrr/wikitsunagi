Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "questions/verify_answer" => "questions#verify_answer"
end
