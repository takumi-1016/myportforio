class PostTitlesController < ApplicationController
  before_action :authenticate_user!
  def show
    @post_title = PostTitle.find(params[:id])
    @post_comment = PostComment.new
    @tags = @post_title.tags
    @comments = if current_user.certification_id
                  if current_user.certification_id == @post_title.team.certification_id
                    PostComment.where(post_title_id: @post_title.id)
                  else
                    PostComment.where(post_title_id: @post_title.id).where(private: false)
                  end
                else
                  PostComment.where(post_title_id: @post_title.id).where(private: false)
                end
  end

  def create
    @post_title = PostTitle.new(post_title_params)
    tag_list = params[:post_title][:name].split('、')
    if @post_title.save
      @post_title.save_tag(tag_list)
      redirect_to myboard_path, notice: 'スレッドを作成しました。'
    else
      redirect_to myboard_path, alert: 'タイトルの入力は必須です'
    end
  end

  def destroy
    @post_title = PostTitle.find(params[:id])
    @post_title.destroy
    redirect_to myboard_path, notice: 'スレッドを削除しました。'
  end

  def search
    @tags = Tag.all
    @tag = Tag.find(params[:tag_id])
    @post_titles = @tag.post_titles.all.page(params[:page]).per(6)
  end

  private

  def post_title_params
    params.require(:post_title).permit(:title, :user_id, :team_id, :private)
  end
end
