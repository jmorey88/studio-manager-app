# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TeachersController, type: :controller do
  let(:user) { create(:teacher) }
  let(:another_user) { create(:teacher, name: "Another Teacher") }

  # before(:each) { session[:user_id] = user.id }

  describe 'GET #show' do
    it 'retrieves a teacher record when authenticated' do
      session[:user_id] = user.id
      get :show, params: { id: user.id } 
      expect(assigns(:teacher).id).to eq (user.id)
      expect(response).to render_template(:show)
    end
    it "redirects to root when not authenticated" do 
      get :show, params: { id: user.id }
      expect(assigns(:teacher)).to eq (nil)
      expect(response).to redirect_to(root_path)
    end
    it "redirects to root when not authorized" do
      session[:user_id] = another_user.id
      get :show, params: { id: user.id }
      expect(assigns(:teacher)).to eq (nil)
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #edit' do
    it 'retrieves a teacher record when authenticated' do
      session[:user_id] = user.id
      get :edit, params: { id: user.id }
      expect(assigns(:teacher).id).to eq (user.id)
      expect(response).to render_template(:edit)
    end
    it "redirects to root when not authenticated" do
      get :edit, params: { id: user.id }
      expect(assigns(:teacher)).to eq (nil)
      expect(response).to redirect_to(root_path) 
    end
    it "redirects to root when not authorized" do 
      session[:user_id] = another_user.id
      get :edit, params: { id: user.id }
      expect(assigns(:teacher)).to eq (nil)
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'PATCH #update' do
    it 'updates a teacher record when authenticated' do
      session[:user_id] = user.id
      new_email = "new_email@mail.com"
      patch :update, params: { id: user.id, user: { email: new_email }}
      expect(assigns(:teacher).email).to eq (new_email)
      expect(response).to redirect_to(teacher_path)
    end
    it "redirect to root when not authenticated" do
      patch :update, params: { id: user.id }
      expect(assigns(:teacher)).to eq (nil)
      # expect(assigns(:teacher).email).to eq ((:teacher).email)
      expect(response).to redirect_to(root_path)
    end 
    it "redirect to root when not authorized" do 
      session[:user_id] = another_user.id
      patch :update, params: { id: user.id }
      expect(assigns(:teacher)).to eq (nil)
      expect(response).to redirect_to(root_path)
    end
  end
end