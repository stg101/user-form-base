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
      @user.write_attribute(:last_name, last_name_refactor(@user[:last_name]))
      @user.save      
      redirect_to "/users", status: 301
    else
      errors = @user.errors.full_messages      
      redirect_to "/users/new", status: 301, flash: {errors: errors}
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

  def last_name_refactor(last_name)
    last_name_array = last_name.downcase.split(' ')  

    articles = [
      "de",
      "del",
      "la",
      "las",
      "los"
    ]

    last_name_array.map! do |word|
      if articles.include? word 
        word
      else
        word.capitalize
      end
    end

    last_name_array.join(' ')
  end

end
