require 'rails_helper'

RSpec.describe 'Users', type: :system do
  # let!(:user) { create(:user, certification_id: team.certification_id, team_id: team.id) }
  # let!(:team) { create(:team) }

  # let!(:other_user) { create(:user, certification_id: other_team.certification_id, team_id: other_team.id) }
  # let!(:other_team) { create(:team) }

  # let!(:user_no_team) { create(:user, certification_id: nil, team_id: nil) }

  # let!(:post_title) { create(:post_title, team_id: team.id) }

  # let!(:other_post_title) { create(:post_title, team_id: other_team.id) }

  # let!(:post_comment) { create(:post_comment, user_id: user.id, post_title_id: post_title.id) }

  # describe 'ユーザー機能の確認' do
  #   describe 'ユーザーの新規登録' do
  #     before do
  #       visit new_user_registration_path
  #     end
  #     context '新規登録画面に遷移' do
  #       it '新規登録に成功しユーザーが登録されること' do
  #         fill_in 'ユーザーネーム', with: 'test'
  #         fill_in 'Eメール', with: 'test@example.com'
  #         fill_in 'パスワード', with: 'testtest'
  #         fill_in 'パスワード（確認用）', with: 'testtest'
  #         click_button '上記の内容で登録する'
  #         expect(page).to have_content 'チーム認証IDを確認しているチームに参加できます。また、チームを作成して参加できることもできます。'
  #       end
  #     end
  #   end
  #   describe 'ユーザーログイン' do
  #     before do
  #       visit new_user_session_path
  #     end

  #     context 'ログイン画面に遷移' do
  #       it 'ログインに成功する' do
  #         fill_in 'Eメール', with: user.email
  #         fill_in 'パスワード', with: user.password
  #         click_button 'ログイン'
  #         expect(page).to have_content 'ログインしました。'
  #       end

  #       it 'ログインに失敗する' do
  #         fill_in 'Eメール', with: ''
  #         fill_in 'パスワード', with: ''
  #         click_button 'ログイン'
  #         expect(current_path).to eq new_user_session_path
  #       end
  #     end
  #   end

  #   describe 'ログイン後の機能' do
  #     context 'チーム登録しているユーザーの場合' do
  #       before do
  #         visit new_user_session_path
  #         fill_in 'Eメール', with: user.email
  #         fill_in 'パスワード', with: user.password
  #         click_button 'ログイン'
  #       end
  #       it 'チーム掲示板にアクセスできること' do
  #         expect(current_path).to eq myboard_path
  #       end
  #       it 'マイチームページにアクセスできること' do
  #         click_link('マイチーム')
  #         expect(current_path).to eq myteam_path
  #       end
  #       it 'マイページにアクセスできること' do
  #         click_link('マイページ')
  #         expect(current_path).to eq mypage_path
  #       end
  #       it 'チーム一覧にアクセスできること' do
  #         click_link('チーム一覧')
  #         expect(current_path).to eq teams_path
  #       end
  #       it 'チーム作成ページにアクセスできないこと' do
  #         click_link('チーム作成')
  #         expect { visit new_team_path }.to change { current_path }.from(new_team_path).to(edit_user_path(user))
  #       end
  #       it 'プロフィール編集できること' do
  #         visit edit_user_path(user)
  #         fill_in 'ユーザーネーム', with: '変更ネーム'
  #         click_button 'プロフィールを更新する'
  #         visit user_path(user)
  #         expect(page).to have_content '変更ネーム'
  #       end
  #       it 'チームを退会できること' do
  #         visit edit_user_path(user)
  #         click_button "#{user.team.team_name}からから退会する"
  #         visit user_path(user)
  #         expect(page).to have_content 'チームに所属していません。'
  #       end
  #     end

  #     context 'チーム登録していないユーザーの場合' do
  #       before do
  #         visit new_user_session_path
  #         fill_in 'Eメール', with: user_no_team.email
  #         fill_in 'パスワード', with: user_no_team.password
  #         click_button 'ログイン'
  #       end
  #       it 'チーム一覧にアクセスできること' do
  #         click_link('チーム一覧')
  #         expect(current_path).to eq teams_path
  #       end
  #       it 'チーム作成ページにアクセスできること' do
  #         click_link('チーム作成')
  #         expect(current_path).to eq new_team_path
  #       end
  #     end
  #   end
  # end
end
