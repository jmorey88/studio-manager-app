Rails.application.routes.draw do
  get 'students/edit'
  root "pages#home"

  get "/help",           to:  "pages#help"
  get "/signup",         to:  "sessions#signup"
  post "/signup",       to:  "sessions#create_teacher"
  get "/login",          to:  "sessions#login"
  post "/login",         to: "sessions#create_session"
  delete "/logout",      to: "sessions#destroy"

  resources :students 
  resources :teachers
end
