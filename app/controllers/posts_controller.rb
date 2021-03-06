class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]


  def create
    if params[:post].present? 
      @post = current_user.posts.build(post_params)
      @post.save
       flash[:success] = '投稿しました。'
       redirect_to root_url
    else
       @post = current_user.posts.build
       @posts = current_user.feed_posts.order(id: :desc).page(params[:page])
       flash[:danger] = "投稿に失敗しました。"
       render 'toppages/index'
    end
  end    

  def destroy
    @post.destroy
    flash[:success] = "メッセージを削除しました。"
    redirect_back(fallback_location: root_path)
  end

  private
    
    def post_params
     params.require(:post).permit(:image)
    end
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      unless @post
        redirect_to root_url
      end
    end
end  


