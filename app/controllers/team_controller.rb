class TeamController < ApplicationController
  before_action :set_user
  before_action :set_team, only: [:show, :edit, :update]
  before_action :authenticate_user!
  def index
    @teams = Team.all
  end

  def show
    @members = User.where(team_id: @team.id)
    @post_titles = PostTitle.where(team_id: @team.id).page(params[:page]).per(6)
  end

  def myteam
    if @user.certification_id
      if  @user.certification_id ==  @user.team.certification_id
        redirect_to team_path(@user.team.id)
      else
        redirect_to teams_path, notice:"チーム認証IDを確認しているチームに参加できます。また、チームを作成して参加することもできます。"
      end
    else
      redirect_to teams_path, notice:"チーム認証IDを確認しているチームに参加できます。また、チームを作成して参加することもできます。"
    end
  end

  def myboard
    if @user.certification_id
      if @user.team.certification_id == @user.certification_id
        @q = PostTitle.where(team_id: @user.team.id).preload(:user).ransack(params[:q])
        @post_titles = @q.result(distinct: true).page(params[:page]).per(6)
        @tags = Tag.all
        @post_title = PostTitle.new(post_title_params)
        @post_comment = PostComment.new(post_comment_params)
        if @post_comment.save
          redirect_to myboard_path, notice:"コメントを投稿しました。"
        end
        if @post_title.save
          redirect_to myboard_path, notice:"スレッドを作成しました。"
        end
      else
        redirect_to teams_path, notice:"チーム認証IDを確認しているチームに参加できます。また、チームを作成して参加することもできます。"
      end
    else
      redirect_to teams_path, notice:"チーム認証IDを確認しているチームに参加できます。また、チームを作成して参加することもできます。"
    end
  end

  def teamboard
    @team = Team.find(params[:team_id])
    if current_user.certification_id
      if @user.certification_id == @team.certification_id
        redirect_to myboard_path
      else
        @q = PostTitle.where(team_id: @team.id).preload(:user).ransack(params[:q])
        @post_titles = @q.result(distinct: true).page(params[:page]).per(6)
      end
    else
      @q = PostTitle.where(team_id: @team.id).preload(:user).ransack(params[:q])
      @post_titles = @q.result(distinct: true).page(params[:page]).per(6)
    end
  end
  
  def new
    if current_user.certification_id
      redirect_to user_path(current_user.id), notice:"すでにチームに参加しています。チーム作成の際はマイページ→プロフィール編集からチームを退会してください。"
    else
      @team = Team.new
    end
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to team_registration_path(@team), notice:"チームを作成しました。チーム認証IDに”#{@team.certification_id}”を入力してチームに参加してください。。"
    else
      flash[:alert] = "必須項目に入力してください"
      render "new"
    end
  end

  def registration
    @team = Team.find(params[:team_id])
    if  @user.team_id == @team.id
    else
      redirect_to teams_path, notice:"#{"チームに参加する"}ボタンからチーム認証を行ってください。"
    end
  end

  def team_certification
    @team = Team.find(params[:team_id])
    if @user.update(user_params) 
      if @team.certification_id == @user.certification_id
        redirect_to team_path(@team), notice:"チーム認証が完了し、#{@team.team_name}に参加しました"
      else
        @user.update(:certification_id => nil)
        @user.update(:team_id => nil)
        redirect_to teams_path, alert:"チーム参加IDが異なります。#{"チームに参加する"}ボタンからもう一度チーム認証を行ってください。"
      end
    else
      render team_team_certification_path, notice:"#{"チームに参加する"}ボタンからチーム認証を行ってください。"
    end   
  end

  def edit
    unless (@user.team.id == @team.id && @user.certification_id == @team.certification_id)
      redirect_to team_path(@team)
    end
  end

  def update
    if @team.update(team_params)
        redirect_to team_path
    else
        render "show"
    end
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end
  def set_user
    @user = current_user
  end
  def search
    @q = Post_.ransack(params[:q])
  end

  def team_params
    params.require(:team).permit(:team_name, :team_profile, :team_image, :certification_id)
  end
  def user_params
    params.require(:user).permit(:team_id, :certification_id)
  end
  def post_comment_params
    params.permit(:comment, :user_id, :team_id, :post_title_id, :private)
  end
  def post_title_params
    params.permit(:title, :user_id, :team_id, :private)
  end

end
