require 'rails_helper'

RSpec.describe 'PostTitles', type: :request do
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

  let!(:tag) { create(:tag) }
  let!(:tag_relationship) { create(:tag_relationship, tag_id: tag.id, post_title_id: post_title.id) }

  let!(:valid_params) { attributes_for(:post_title, title: 'post_title', user_id: user.id, team_id: team.id) }

  before do
    sign_in user
  end

  describe 'GET /show' do
    it 'スレッド画面が表示されること' do
      get post_title_path(post_title)
      expect(response).to have_http_status(:success)
    end

    it 'スレッドのコメントが表示されること' do
      get post_title_path(post_title)
      expect(response.body).to include(post_comment.comment)
    end
  end

  # describe 'POST /create' do
  #   post post_titles_path(post_title.id)
  #   expect(response).to have_http_status(200)
  # end

  # describe 'PUCTH /destroy' do
  #   delete post_titles_path(post_title)
  #   expect(team.post_titles.reload).not_to include post_title
  # end

  describe 'GET /search' do
    it 'スレッド検索結果画面が表示されること' do
      get tag_search_path(tag)
      expect(response).to have_http_status(:success)
    end

    it '指定したタグのついたスレッドが表示されること' do
      get tag_search_path(tag)
      expect(response.body).to include(post_title.title)
      expect(response.body).not_to include(other_post_title.title)
    end
  end
end
