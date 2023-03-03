class SessionsController < ApplicationController
  def signup 
    @user = User.new
  end

  def create_teacher
     @user = User.new(user_params)
     if @user.save
      reset_session 
      log_in @user
      flash[:success] = "Welcome to Your Studio!"
      redirect_to dashboard_url
     else
      render 'signup', status: :unprocessable_entity
     end
  end

  def show
    @user = User.find(params[:id])
  end 

  def login
  end

  def create_session
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      reset_session
      log_in user
      redirect_to dashboard_url
    else
      flash.now[:danger] = 'Invalid email/password combination'
    render "login", status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
