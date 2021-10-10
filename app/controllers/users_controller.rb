class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to '/'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def index
    s= params[:search]
    if (s.nil? )
      @users = User.all
    else
      @users = User.where('name like (?)',"%#{s}%")
        if (@users.nil?)
          @users = User.all
        end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end

  def delete
    User.find(params[:id]).destroy
    redirect_to :action => 'index'
  end

end
