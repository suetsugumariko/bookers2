class UsersController < ApplicationController
  before_action :authenticate_user!


  def new
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.where(user_id: @user)
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end


 def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: 'Signed in successfully'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :index
    end
 end


  def update
     @user = User.find(params[:id])
     if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully'
      redirect_to user_path(@user.id)
     else
      render :edit
     end
  end






  def login_form
  end



   private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end



end
