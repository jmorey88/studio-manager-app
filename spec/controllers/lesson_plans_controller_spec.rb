# require "rails_helper"

RSpec.describe LessonPlansController, type: :controller do
  let(:lesson_plan) { create(:lesson_plan) }
  let(:user) { create(:teacher) }
  let(:another_user) { create(:teacher, name: "Another Teacher") }
  let(:student_user) { create(:student, name: "Student User", teacher_id: user.id) }
  let(:valid_user_params) { 
    { name: "New Student", 
      email: "new.student@email.com", 
      password: "fakepassword", 
      password_confirmation: "fakepassword" } 
  }

  describe 'GET #new' do
    it 'retrieves new lesson_plan form when authenticated' do
      session[:user_id] = user.id
      get :new
      expect(assigns(:lesson_plan)).to be_instance_of(LessonPlan)
      expect(response).to render_template(:new)
    end
    it 'redirects to root when not authenticated' do
    end
  end

  # describe 'POST #create' do
  #   it 'creates new lesson plan when authenticated' do 
  #   end
  #   it 'redirects to root when not authenticated' do
  #   end
  # end

  # describe 'GET #show' do 
  #   it 'shows lesson plan record when autheticated' do 
  #   end
  #   it 'redirects to root when not authenticated' do 
  #   end
  # end

  # descirbe 'GET #index' do 
  #   it 'returns list of lesson plans when authenticated' do 
  #   end
  #   it 'it redirects to root when not authenticated' do 
  #   end
  # end

  # describe 'GET #edit' do
  #   it 'retrieves lesson plan edit form when authenticated' do
  #   end
  #   it 'redirects to root when not authenticated' do 
  #   end
  # end

  # describe 'PATCH #update' do
  #   it 'updates lesson plan record when authenticated' do 
  #   end
  #   it 'redirect to root when not authenticated' do 
  #   end
  # end

  # describe 'DELETE #destroy' do
  #   it 'deletes lesson plan recrod when authenticated' do 
  #   end 
  #   it 'redirects to root when not authenticated' do 
  #   end
  # end
end