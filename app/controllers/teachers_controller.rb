class TeachersController < ApplicationController
  before_action :authorize_teacher

  def show
    @teacher = User.teachers.find(params[:id])
  end 

  def edit
    @teacher = User.teachers.find(params[:id])
  end

  def update
    @teacher = User.teachers.find(params[:id])
    if @teacher.update(teacher_params)
      flash[:success] = "Profile updated"
      redirect_to teacher_path
    else
      redirect_to edit_teacher_path
      flash[:danger] = 'unsuccessful signup' 
    end
  end

  private 

  def teacher_params
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end

  def authorize_teacher
    return true if current_user.id == params[:id]&.to_i

    flash[:error] = "Not authorized to view this page"
    redirect_to root_path
  end
end
