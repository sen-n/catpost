class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]


  def create
    @post = current_user.posts.build
      if @post.save
        flash[:success] = '投稿しました。'
        redirect_to root_url
      else
        @posts = current_user.feed_posts.order(id: :desc).page(params[:page])
        flash[:danger] = "投稿に失敗しました。"
        redirect_back(fallback_location: root_path)
      end
  end


  def destroy
    @post.destroy
    flash[:success] = "メッセージを削除しました。"
    redirect_back(fallback_location: root_path)
  end

  private

    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      unless @post
        redirect_to root_url
      end
    end
end
