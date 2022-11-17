class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!
  protect_from_forgery
  def show
    @team = @user.team
  end

  def mypage
    redirect_to user_path(current_user)
  end

  def user_posts
    @user = User.find(params[:user_id])
    @post_comments = if current_user.certification_id
                       if current_user.certification_id == @user.team.certification_id
                         @user.post_comments.page(params[:page]).per(6)
                       else
                         @user.post_comments.where(private: false).page(params[:page]).per(6)
                       end
                     else
                       @user.post_comments.where(private: false).page(params[:page]).per(6)
                     end
  end

  def user_likes
    @user = User.find(params[:user_id])
    like_comments_list = Like.where(user_id: @user.id)
    like_comments_list_id = like_comments_list.pluck(:post_comment_id)
    @like_comments = if current_user.certification_id
                       if current_user.certification_id == @user.team.certification_id
                         PostComment.where(id: like_comments_list_id).page(params[:page]).per(6)
                       else
                         PostComment.where(id: like_comments_list_id).where(private: false).page(params[:page]).per(6)
                       end
                     else
                       PostComment.where(id: like_comments_list_id).where(private: false).page(params[:page]).per(6)
                     end
  end

  def edit
    return if @user == current_user

    redirect_to user_path(@user)
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def withdrow_team
    user = User.find(params[:user_id])
    user.update(certification_id: nil)
    user.update(team_id: nil)
    redirect_to mypage_path, notice: 'チームを退会しました'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :user_profile, :user_image, :team_id, :certification_id)
  end
end
