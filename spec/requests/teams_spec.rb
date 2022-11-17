require 'rails_helper'

RSpec.describe 'Teams', type: :request do
  let!(:user) { create(:user, certification_id: team.certification_id, team_id: team.id) }
  let!(:team) { create(:team) }

  let!(:other_user) { create(:user, certification_id: other_team.certification_id, team_id: other_team.id) }
  let!(:other_team) { create(:team) }

  let!(:user_no_team) { create(:user, certification_id: nil, team_id: nil) }

  let!(:post_title) { create(:post_title, team_id: team.id) }

  let!(:other_post_title) { create(:post_title, team_id: other_team.id) }

  let!(:post_comment) { create(:post_comment, user_id: user.id, post_title_id: post_title.id) }

  let!(:other_post_comment1) { create(:post_comment, user_id: other_user.id, private: false, post_title_id: other_post_title.id) }

  let!(:other_post_comment2) { create(:post_comment, user_id: other_user.id, private: true, post_title_id: other_post_title.id) }

  context 'チームに所属する人がアクセスする時' do
    before do
      sign_in user
    end
    describe 'GET /index' do
      it 'チーム一覧画面が表示されること' do
        get teams_path
        expect(response).to have_http_status(:success)
      end

      it 'チーム一覧が表示されること' do
        get teams_path
        expect(response.body).to include(team.team_name)
        expect(response.body).to include(other_team.team_name)
      end
    end

    describe 'GET /show' do
      it 'チーム詳細画面が表示されること' do
        get team_path(team)
        expect(response).to have_http_status(:success)
      end
      it 'チーム詳細画面にチーム情報が表示されること' do
        get team_path(other_team)
        expect(response.body).to include(other_team.team_name)
        expect(response.body).to include(other_team.team_profile)
      end

      it 'チーム詳細画面にチームメンバーが表示されること' do
        get team_path(other_team)
        expect(response.body).to include(other_user.user_name)
      end

      it 'チーム詳細画面にチームの作成したスレッドが表示されること' do
        get team_path(team)
        expect(response.body).to include(post_title.title)
        expect(response.body).not_to include(other_post_title.title)
      end
    end

    describe 'GET /myboard' do
      it 'マイチームの掲示板画面が表示されること' do
        get myboard_path
        expect(response).to have_http_status(:success)
      end

      it 'マイチームの掲示板画面にチームの作成したスレッドが表示されること' do
        get myboard_path(team)
        expect(response.body).to include(post_title.title)
        expect(response.body).not_to include(other_post_title.title)
      end

      it 'マイチームの掲示板画面にチームの作成したスレッドにそのコメントが表示されること' do
        get myboard_path(team)
        expect(response.body).to include(post_comment.comment)
        expect(response.body).not_to include(other_post_comment1.comment)
      end
    end

    describe 'GET /teamboard' do
      it 'チームの掲示板が表示されること' do
        get team_teamboard_path(other_team)
        expect(response).to have_http_status(:success)
      end

      it 'チームが作成したスレッドとそのコメントが表示されること' do
        get team_teamboard_path(other_team)
        expect(response.body).to include(other_post_title.title)
        expect(response.body).to include(other_post_comment1.comment)
      end

      it 'privateがtrueなコメントは他チームのメンバーには表示されないこと' do
        get team_teamboard_path(other_team)
        expect(response.body).to include(other_post_title.title)
        expect(response.body).not_to include(other_post_comment2.comment)
      end
    end

    describe 'GET /edit' do
      it 'チーム編集画面が表示されること' do
        get edit_team_path(team)
        expect(response).to have_http_status(:success)
      end
    end
  end

  context 'チームに所属していない人がアクセスする時' do
    before do
      sign_in user_no_team
    end
    describe 'GET /new' do
      it 'チーム作成画面が表示されること' do
        get new_team_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /registration' do
      it 'チーム登録画面が表示されること' do
        get team_registration_path(team)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
