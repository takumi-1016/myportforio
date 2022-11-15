class UsersController < ApplicationController
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]
    before_action :authenticate_user!
    protect_from_forgery
    def show
      @team = @user.team
      @comments = if current_user.certification_id
                    if current_user.certification_id == @team.certification_id
                      PostComment.where(user_id: @user.id).page(params[:page]).per(6)
                    else
                      PostComment.where(user_id: @user.id).where(private: false).page(params[:page]).per(6)
                    end
                  else
                    PostComment.where(user_id: @user.id).where(private: false).page(params[:page]).per(6)
                  end
    end

    def mypage
      redirect_to user_path(current_user)
    end

    def edit
      return if @user == current_user

      redirect_to user_path(@user)
    end

    def team_id_registration
      if current_user.update(user_params)
        redirect_to team_registration_path(current_user.team.id)
      else
        redirect_to team_path(params[:team_id])
      end
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
end