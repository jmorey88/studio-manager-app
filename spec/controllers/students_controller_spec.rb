# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let(:user) { create(:teacher) }
  let(:another_user) { create(:teacher, name: "Another Teacher") }
  let(:student_user) { create(:student, name: "Student User", teacher_id: user.id) }
  let(:valid_user_params) { 
    { name: "New Student", 
      email: "new.student@email.com", 
      password: "fakepassword", 
      password_confirmation: "fakepassword" } 
  }


  describe 'GET #show' do
    it "retrieves a student record when authenticated" do
      session[:user_id] = user.id
      get :show, params: { id: student_user.id }
      expect(assigns(:student).id).to eq (student_user.id)
      expect(response).to render_template(:show)
    end
    it "redirects to root when not authenticated" do
      get :show, params: { id: student_user.id }
      expect(assigns(:student)).to be_nil
      expect(response).to redirect_to(root_path)
    end
    it "redirects to root when not authorized" do
      session[:user_id] = another_user.id
      get :show, params: { id: student_user.id }
      expect(assigns(:student)).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #index' do
    it "retrieves list of all teacher's students when authenticated" do
      session[:user_id] = user.id
      get :index 
      expect(assigns(:students)).to include(student_user)
      expect(response).to render_template(:index)
    end
    it "redirects to root when not authenticated" do
      get :index
      expect(assigns(:students)).to be_nil
      expect(response).to redirect_to(root_path)
    end
    it "only retrieves authorized students" do
      session[:user_id] = another_user.id
      get :index 
      expect(assigns(:students)).not_to include(student_user)
    end
  end

  describe 'GET #new' do
    it "gets form for new student when authenticated" do
      session[:user_id] = user.id
      get :new
      expect(assigns(:student)).to be_instance_of(User)
      expect(response).to render_template(:new)
    end
    it "redirects to root when not authenticated" do
      get :new
      expect(assigns(:student)).to be_nil
      expect(response).to redirect_to(root_path)
    end 
  end

  describe 'POST #create' do 
    it "adds new student record when authenticated" do
      session[:user_id] = user.id 
      post :create, params: { user: valid_user_params }
      expect(assigns(:student).id).to eq User.last.id
      expect(assigns(:student).name).to eq valid_user_params[:name]
      expect(response).to redirect_to(student_path(id: assigns(:student).id)) 
    end
    it "redirects to root when not authenticated" do 
      before_count = User.count
      post :create, params: { user: valid_user_params }
      expect(User.count).to eq before_count
      expect(response).to redirect_to(root_path)
    end
    it "shows error and returns to form when new student info is invalid" do 
      session[:user_id] = user.id
      before_count = User.count
      invalid_user_params = valid_user_params
      invalid_user_params[:name] = nil
      post :create, params: { user: invalid_user_params }
      expect(assigns(:student).id).to be_nil
      expect(User.count).to eq before_count
      expect(response).to redirect_to(new_student_path)
    end
  end

  describe 'GET #edit' do
    it 'retrieves a student record when authenticated' do
      session[:user_id] = user.id
      get :edit, params: { id: student_user.id }
      expect(assigns(:student).id).to eq (student_user.id)
      expect(response).to render_template(:edit)
    end
    it "redirects to root when not authenticated" do
      get :edit, params: { id: student_user.id }
      expect(assigns(:student)).to be_nil
      expect(response).to redirect_to(root_path) 
    end
    it "redirects to root when not authorized" do 
      session[:user_id] = another_user.id
      get :edit, params: { id: student_user.id }
      expect(assigns(:student)).to be_nil
      expect(response).to redirect_to(students_path)
    end
  end

  describe 'PATCH #update' do
    it 'updates a student record when authenticated' do
      session[:user_id] = user.id
      new_email = "new_email@mail.com"
      patch :update, params: { id: student_user.id, user: { email: new_email }}
      expect(assigns(:student).email).to eq (new_email)
      expect(response).to redirect_to(student_path)
    end
    it "redirect to root when not authenticated" do
      patch :update, params: { id: student_user.id }
      expect(assigns(:student)).to be_nil
      expect(response).to redirect_to(root_path)
    end 
    it "redirect to root when not authorized" do 
      session[:user_id] = another_user.id
      patch :update, params: { id: student_user.id, user: { email: "new@mail.com" } }
      expect(assigns(:student)).to be_nil
      expect(response).to redirect_to(edit_student_path(student_user))
    end
  end
  
  describe 'DELETE #destroy' do 
    it "deletes student record when authenticated" do
      session[:user_id] = user.id
      student_user
      before_count = User.count
      delete :destroy, params: { id: student_user.id } 
      expect(User.count).to eq before_count - 1
      expect(response).to redirect_to students_path
    end
    it "redirects to root when not authenticated" do
      student_user
      before_count = User.count
      delete :destroy, params: { id: student_user.id } 
      expect(User.count).to eq before_count
      expect(response).to redirect_to root_path
    end
    it "redirects to root when not authorized" do
      session[:user_id] = another_user.id
      student_user
      before_count = User.count
      delete :destroy, params: { id: student_user.id } 
      expect(User.count).to eq before_count
      expect(response).to redirect_to students_path
    end 
  end
end