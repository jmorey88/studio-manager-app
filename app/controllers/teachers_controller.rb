class TeachersController < ApplicationController
 
  def show
    @teacher = User.find(params[:id])
  end 

  def edit
    @teacher = User.find(params[:id])
  end

  def update
    @teacher = User.find(params[:id])
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

end
