# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:teacher) }
  let(:another_user) { create(:teacher, name: 'Another Teacher') }
  let(:valid_session) do
  end
  let(:valid_user_params) do
    { name: 'New Student',
      email: 'new.student@email.com',
      password: 'fakepassword',
      password_confirmation: 'fakepassword' }
  end

  describe 'GET #signup' do
    it 'instantiates new user signup form' do
      get :signup
      expect(assigns(:teacher)).to be_instance_of User
      expect(response).to render_template(:signup)
    end
  end

  describe 'POST #create_teacher' do
    it 'creates new user and session given valid params' do
      post :create_teacher, params: { user: valid_user_params }
      expect(assigns(:teacher).id).to eq User.last.id
      expect(controller.current_user.email).to eq valid_user_params[:email]
      expect(response).to redirect_to(teacher_path(assigns(:teacher)))
    end
    it 'only creates user with teacher role' do
      updated_user_params = valid_user_params
      updated_user_params[:role] = User::STUDENT_ROLE
      post :create_teacher, params: { user: updated_user_params }
      expect(assigns(:teacher).id).not_to be_nil
      expect(assigns(:teacher).roles).to eq 'teacher'
    end
    it 'returns to signup form without logging in given invalid params' do
      invalid_user_params = valid_user_params
      invalid_user_params[:name] = nil
      post :create_teacher, params: { user: invalid_user_params }
      expect(assigns(:teacher).id).to be_nil
      expect(controller.current_user).to be_nil
      expect(response.status).to eq(422)
      expect(response).to render_template(:signup)
    end
  end

  describe 'GET #login' do
    it 'renders login template' do
      get :login
      expect(response).to render_template(:login)
    end
  end

  describe 'POST #create_session' do
    it 'creates session and redirects given valid credentials' do
      post :create_session, params: { session: {
        email: user.email,
        password: user.password
      } }
      expect(session[:user_id]).to eq(user.id)
      expect(response).to redirect_to(teacher_path(assigns(:user)))
    end
    it 'does not create session given invalid password' do
      post :create_session, params: { session: {
        email: user.email,
        password: 'invalid'
      } }
      expect(session[:user_id]).to be_nil
      expect(response.status).to eq(422)
    end
    it ' does not create session given invalid email' do
      post :create_session, params: { session: {
        email: 'invalid',
        password: user.password
      } }
      expect(session[:user_id]).to be_nil
      expect(response.status).to eq(422)
    end
  end

  describe 'DELETE #destroy' do
    it 'resets session and redirects to root when authenticated' do
      session[:user_id] = user.id
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end
end
