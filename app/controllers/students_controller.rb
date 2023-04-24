
class StudentsController < ApplicationController
  before_action :authenticate

  def show
    @student = current_user.students.where(id: params[:id]).first
    unless @student 
      flash[:error] = "student #{params[:id]} doesn't exist"
      redirect_to root_path
    end
  end

  def index
    @students = current_user.students
  end

  def new
    @student = User.new
  end

  def create
      @student = User.new(student_params)
     @student.roles = User::STUDENT_ROLE
     @student.teacher_id = current_user.id
     if @student.save
      flash[:success] = "New Student Created"
      redirect_to student_path(@student)
     else
      flash[:error] = "unsuccessful signup"
      redirect_to new_student_path
     end
  end

  def edit
    @student = current_user.students.find(params[:id])
  end

  def update
    @student = current_user.students.find(params[:id])
    if @student.update(student_params)
      flash[:success] = "Profile updated"
      redirect_to student_path(@student)
    else
      redirect_to edit_student_path
      flash[:danger] = 'unsuccessful update'
    end
  end

  def destroy
    @student = current_user.students.find(params[:id])
    @student.destroy
    flash[:success] = "Student deleted"
    redirect_to students_path
  end

  private
    def student_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end


end
