class PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post_comment = PostComment.new(post_comment_params)
    if @post_comment.save
      redirect_to post_title_path(@post_comment.post_title.id), notice: 'コメントを投稿しました。'
    else
      redirect_to myboard_path, alert: 'コメントの入力は必須です'
    end
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_to post_title_path(@post_comment.post_title.id), notice: 'コメントを削除しました。'
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :user_id, :team_id, :post_title_id, :private)
  end
end
