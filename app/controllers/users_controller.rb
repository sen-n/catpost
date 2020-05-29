class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :update, :followings, :followers, :like_posts]
  before_action :correct_user,   only: [:edit, :update]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end
  

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = '登録完了しました。'
      redirect_to @user
    else
      flash.now[:danger] = '登録に失敗しました。'
      render :new
    end
  end
  

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:success] = "プロフィールを編集しました。"
        redirect_to @user
      else
        flash.now[:danger] = "プロフィールの編集に失敗しました。"
        render :edit
      end 
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def like_posts
    @user = User.find(params[:id])
    @like_posts = @user.like_posts.page(params[:page])
    counts(@user)
  end


  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile)
  end
  
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
  end
  
end  