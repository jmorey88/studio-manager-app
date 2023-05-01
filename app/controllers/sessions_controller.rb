class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:signup, 
                                           :create_teacher,
                                           :login,
                                           :create_session]
  
  def signup 
    @teacher = User.new
  end

  def create_teacher
     @teacher = User.new(user_params)
     @teacher.roles = User::TEACHER_ROLE
     if @teacher.save
      reset_session 
      log_in @teacher
      flash[:success] = "Welcome to Your Studio!"
      redirect_to teacher_path(@teacher)
     else
      render 'signup', status: :unprocessable_entity
     end
  end

  def login
  end

  def create_session
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      reset_session
      log_in @user
      redirect_to teacher_path(@user)
    else
      flash[:error] = 'Invalid email/password combination'
    render "login", status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    @current_user = nil
    redirect_to root_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def log_in(user)
      session[:user_id] = user.id
    end
end
