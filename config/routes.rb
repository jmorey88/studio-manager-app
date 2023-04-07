Rails.application.routes.draw do
  get 'students/edit'
  root "pages#home"

  get "/help",           to:  "pages#help"
  get "/signup",         to:  "sessions#signup"
  post "/signup",       to:  "sessions#create_teacher"
  get "/login",          to:  "sessions#login"
  post "/login",         to: "sessions#create_session"
  delete "/logout",      to: "sessions#destroy"

  # get "/student_lessons/:id", to: "lesson_plans#show_student_lessons", as: "student_lessons"

  resources :students 
  resources :teachers
  resources :lesson_plans
end
