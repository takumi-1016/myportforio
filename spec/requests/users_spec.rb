require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user, certification_id: team.certification_id, team_id: team.id) }
  let!(:team) { create(:team) }
  let!(:other_user) { create(:user, certification_id: other_team.certification_id, team_id: other_team.id) }
  let!(:other_team) { create(:team) }
  let!(:post_comment) { create(:post_comment, user_id: user.id) }
  let!(:other_post_comment1) { create(:post_comment, user_id: other_user.id, private: false) }
  let!(:other_post_comment2) { create(:post_comment, user_id: other_user.id, private: true) }
  let!(:like) { create(:like, user_id: user.id, post_comment_id: other_post_comment1.id) }

  describe 'GET /show' do
    context 'マイページにアクセスしたとき' do
      before do
        sign_in user
      end
      it '自分のユーザー詳細画面が表示されること' do
        get user_path(user)
        expect(response).to have_http_status(:success)
      end

      it '自分のユーザー詳細画面に自分の情報が表示されること' do
        get user_path(user)
        expect(response.body).to include(user.user_name)
        expect(response.body).to include(user.user_profile)
      end

      it '自分のユーザー詳細画面に自分のコメント数が表示されること' do
        get user_path(user)
        expect(response.body).to include(user.post_comments.count.to_s)
      end

      it '自分のユーザー詳細画面に自分のチーム名が表示されること' do
        get user_path(user)
        expect(response.body).to include(user.team.team_name)
      end
      it '自分のユーザープロフィール編集画面にアクセスし画面を表示できること' do
        get edit_user_path(user)
        expect(response).to have_http_status(:success)
      end
    end

    context '自分以外のユーザーページにアクセスしたとき' do
      before do
        sign_in other_user
      end
      it 'ユーザー詳細画面が表示されること' do
        get user_path(other_user)
        expect(response).to have_http_status(:success)
      end

      it 'ユーザー詳細画面にユーザー情報が表示されること' do
        get user_path(other_user)
        expect(response.body).to include(other_user.user_name)
        expect(response.body).to include(other_user.user_profile)
      end

      it 'ユーザー詳細画面にそのユーザーのコメント数が表示されること' do
        get user_path(other_user)
        expect(response.body).to include(other_user.post_comments.count.to_s)
      end

      it 'ユーザー詳細画面にそのユーザーのチーム名が表示されること' do
        get user_path(other_user)
        expect(response.body).to include(other_user.team.team_name)
      end
    end
  end

  describe 'GET /edit' do
    before do
      sign_in user
    end
    it '自分のユーザー編集画面が表示されること' do
      get edit_user_path(user)
      expect(response).to have_http_status(:success)
    end
    it '他ののユーザー編集画面が表示されないこと' do
      get edit_user_path(other_user)
      expect(response).to redirect_to(user_path(other_user))
    end
  end

  describe 'GET /user_posts' do
    before do
      sign_in user
    end
    it 'ページが正常に表示されること' do
      get user_user_posts_path(user)
      expect(response).to have_http_status(:success)
    end
    it 'ユーザーのコメントのみ表示されること' do
      get user_user_posts_path(user)
      expect(response.body).to include(post_comment.comment)
      expect(response.body).not_to include(other_post_comment1.comment)
    end
  end

  describe 'GET /user_likes' do
    before do
      sign_in user
    end
    it 'ページが正常に表示されること' do
      get user_user_likes_path(user)
      expect(response).to have_http_status(:success)
    end
    it 'ユーザーのコメントのみ表示されること' do
      get user_user_likes_path(user)
      expect(response.body).to include(other_post_comment1.comment)
      expect(response.body).not_to include(post_comment.comment)
    end
  end
end
