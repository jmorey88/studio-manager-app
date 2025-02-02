# frozen_string_literal: true

# This controller is for Student actions
class StudentsController < ApplicationController
  def show
    @student = current_user.students.where(id: params[:id]).first
    return if @student

    flash[:error] = "Student #{params[:id]} doesn't exist."
    redirect_to root_path
  end

  def index
    Benchmark.bm do |x|
      x.report('Students index query without caching:') do
        cache_key = "user_#{current_user.id}_students"
        @students = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
          current_user.students.to_a
        end
      end
    end
  end

  def new
    @student = User.new
  end

  def create
    @student = User.new(student_params)
    @student.roles = User::STUDENT_ROLE
    @student.teacher_id = current_user.id
    if @student.save
      flash[:success] = 'New Student Created.'
      redirect_to student_path(@student)
    else
      flash[:error] = 'Unsuccessful signup.'
      redirect_to new_student_path
    end
  end

  def edit
    @student = current_user.students.where(id: params[:id]).first
    return if @student

    flash[:error] = 'Not authorized to edit these students.'
    redirect_to students_path
  end

  def update
    @student = current_user.students.where(id: params[:id]).first
    if @student&.update(student_params)
      flash[:success] = 'Profile updated.'
      redirect_to student_path(@student)
    else
      redirect_to edit_student_path(params[:id])
      flash[:danger] = 'Unsuccessful update.'
    end
  end

  def destroy
    @student = current_user.students.where(id: params[:id]).first
    if @student&.destroy
      flash[:success] = 'Student deleted.'
    else
      flash[:error] = 'Not authorized to delete this student.'
    end
    redirect_to students_path
  end

  private

  def student_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
