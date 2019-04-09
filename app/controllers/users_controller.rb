class UsersController < ApplicationController
  def index
    @user = User.last
  end

  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)
    
    if @user.valid?
      @user.save
      render json: {message: "successfully created user"}, status: :created
    else
      redirect_to "/users/new", status: 301
    end
        
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :username,
      :email,
      :email_confirmation,
      :password,
      :password_confirmation,
      :password_hint
    )
  end
end
