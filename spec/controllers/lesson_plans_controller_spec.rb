# frozen_string_literal: true

require "rails_helper"

RSpec.describe LessonPlansController, type: :controller do
  let(:user) { create(:teacher) }
  let(:lesson_plan) { create(:lesson_plan, student: student_user) }
  let(:another_user) { create(:teacher, name: "Another Teacher") }
  let(:student_user) { create(:student, name: "Student User", teacher_id: user.id) }
  let(:valid_user_params) { 
    { name: "New Student", 
      email: "new.student@email.com", 
      password: "fakepassword", 
      password_confirmation: "fakepassword" } }
  let(:valid_lesson_plan_params) {
    { title: "New Lesson Plan",
      body: "Lesson Plan Body",
      student_id: student_user.id } }
  

  describe 'GET #new' do
    it 'retrieves new lesson_plan form when authenticated' do
      session[:user_id] = user.id
      get :new
      expect(assigns(:lesson_plan)).to be_instance_of(LessonPlan)
      expect(response).to render_template(:new)
    end
    it 'redirects to root when not authenticated' do
      get :new
      expect(assigns(:lesson_plan)).to be nil
      expect(response).to redirect_to(root_path)
    end
    it "retrieves only authorized students" do
      student_user
      another_student_user = create(:student)
      session[:user_id] = user.id
      get :new
      expect(assigns(:students)).to include(student_user)
      expect(assigns(:students)).not_to include(another_student_user)
    end
  end

  describe 'POST #create' do
    it 'creates new lesson plan when authenticated' do 
      session[:user_id] = user.id 
      post :create, params: { lesson_plan: valid_lesson_plan_params }
      expect(assigns(:lesson_plan).id).to eq LessonPlan.last.id
      expect(assigns(:lesson_plan).title).to eq valid_lesson_plan_params[:title]
      expect(response).to redirect_to(lesson_plan_path(id: assigns(:lesson_plan).id)) 
    end
    it 'redirects to root when not authenticated' do
      before_count = LessonPlan.count
      post :create, params: { lesson_plan: valid_lesson_plan_params }
      expect(LessonPlan.count).to eq before_count
      expect(response).to redirect_to(root_path)
    end
    it "shows error and returns to form when new lesson plan info is invalid" do 
      session[:user_id] = user.id
      before_count = LessonPlan.count
      invalid_lesson_plan_params = valid_lesson_plan_params
      invalid_lesson_plan_params[:student_id] = nil
      post :create, params: { lesson_plan: invalid_lesson_plan_params }
      expect(assigns(:lesson_plan).id).to be_nil
      expect(LessonPlan.count).to eq before_count
      expect(response).to redirect_to(new_lesson_plan_path)
    end
    it "only creates lesson plans for authorized students" do
      session[:user_id] = another_user.id
      unauthorized_lesson_plan_params = valid_lesson_plan_params
      post :create, params: { lesson_plan: unauthorized_lesson_plan_params }
    end
  end

  describe 'GET #show' do 
    it 'shows lesson plan record when authenticated' do 
      session[:user_id] = user.id
      get :show, params: { id: lesson_plan.id }
      expect(assigns(:lesson_plan).id).to eq (lesson_plan.id)
      expect(response).to render_template(:show)
    end
    it 'redirects to root when not authenticated' do 
      get :show, params: { id: lesson_plan.id }
      expect(assigns(:lesson_plan)).to be_nil
      expect(response).to redirect_to(root_path)
    end
    it 'redirects to root when not authorized' do 
      session[:user_id] = another_user.id
      get :show, params: { id: lesson_plan.id }
      expect(assigns(:lesson_plan)).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #index' do 
    it 'returns list of lesson plans when authenticated' do 
      session[:user_id] = user.id
      lesson_plan
      get :index 
      expect(assigns(:lesson_plans)).to include(lesson_plan)
      expect(response).to render_template(:index)
    end
    it 'redirects to root when not authenticated' do 
      lesson_plan
      get :index
      expect(assigns(:lesson_plans)).to be_nil
      expect(response).to redirect_to root_path
    end
    it 'redirect to root when not authorized' do
      session[:user_id] = another_user.id
      lesson_plan
      get :index
      expect(assigns(:lesson_plan)).to be_nil
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET #edit' do
    it 'retrieves lesson plan from record for edit form when authenticated' do
      session[:user_id] = user.id
      get :edit, params: { id: lesson_plan.id }
      expect(assigns(:lesson_plan).id).to eq (lesson_plan.id)
      expect(response).to render_template(:edit)
    end
    it 'redirects to root when not authenticated' do 
      get :edit, params: { id: lesson_plan.id }
      expect(assigns(:lesson_plan)).to be_nil
      expect(response).to redirect_to(root_path) 
    end
    it 'redirects to root when not authorized' do
      session[:user_id] = another_user.id
      get :edit, params: { id: lesson_plan.id }
      expect(assigns(:lesson_plan)).to be_nil
      expect(response).to redirect_to(root_path) 
    end
  end

  describe 'PATCH #update' do
    it 'updates lesson plan record when authenticated' do 
      session[:user_id] = user.id
      new_body = "New Body"
      patch :update, params: { id: lesson_plan.id, lesson_plan: { body: new_body }}
      expect(assigns(:lesson_plan).body).to eq (new_body)
      expect(response).to redirect_to(lesson_plans_path(student_id: assigns(:lesson_plan).student_id))
    end
    it 'redirect to root when not authenticated' do 
      patch :update, params: { id: lesson_plan.id }
      expect(assigns(:lesson_plan)). to be_nil
      expect(response).to redirect_to(root_path)
    end
    it "redirect to root when not authorized" do 
      session[:user_id] = another_user.id
      patch :update, params: { id: lesson_plan.id }
      expect(assigns(:lesson_plan)).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes lesson plan recrod when authenticated' do 
      session[:user_id] = user.id
      before_count = LessonPlan.count
      lesson_plan
      delete :destroy, params: { id: lesson_plan.id } 
      expect(LessonPlan.count).to eq before_count
      expect(response).to redirect_to lesson_plans_path
    end 
    it 'redirects to root when not authenticated' do 
      lesson_plan
      expect { delete :destroy, params: { id: lesson_plan.id } }
        .to change(LessonPlan, :count).by(0)
      expect(response).to redirect_to root_path
    end
    it 'redirects to root when not authorized' do
      session[:user_id] = another_user.id
      lesson_plan
      expect { delete :destroy, params: { id: lesson_plan.id } }
        .to change(LessonPlan, :count).by(0)
      expect(response).to redirect_to root_path
    end
  end
end