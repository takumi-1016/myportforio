RSpec.describe 'Teams', type: :system do
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

  describe 'ユーザー機能の確認' do
    describe 'ユーザーの新規登録' do
      before do
        visit new_user_registration_path
      end
      context "新規登録画面に遷移" do
        it '新規登録に成功しユーザーが登録されること' do
          fill_in 'ユーザーネーム', with: "test"
          fill_in 'Eメール', with: "test@example.com"
          fill_in 'パスワード', with: "testtest"
          fill_in 'パスワード（確認用）', with: "testtest"
          click_button '上記の内容で登録する'
          expect(page).to have_content 'チーム認証IDを確認しているチームに参加できます。また、チームを作成して参加することもできます。'
        end
      end
    end
    describe 'ユーザーログイン' do
      before do
        visit new_user_session_path
      end

      context 'ログイン画面に遷移' do
        it 'ログインに成功する' do
          fill_in "Eメール", with: user.email
          fill_in 'パスワード', with: user.password
          click_button 'ログイン'
          expect(page).to have_content 'ログインしました。'
        end

        it 'ログインに失敗する' do
          fill_in 'Eメール', with: ''
          fill_in 'パスワード', with: ''
          click_button 'ログイン'
          expect(current_path).to eq new_user_session_path
        end
      end
    end

    describe 'ログイン後の機能' do
      context 'チーム登録しているユーザーの場合' do
        before do
          visit new_user_session_path
          fill_in "Eメール", with: user.email
          fill_in 'パスワード', with: user.password
          click_button 'ログイン'
        end
        it 'チーム掲示板にアクセスすること' do
          expect(current_path).to eq myboard_path
        end
        it 'チーム作成ページにアクセスできないこと' do
          click_link('チーム作成')
          expect{ visit new_team_path }.to change {current_path}.from(new_team_path).to(edit_user_path(user))
        end
        

      end
      context 'チーム登録していないユーザーの場合' do
        before do
          visit new_user_session_path
          fill_in "Eメール", with: user_no_team.email
          fill_in 'パスワード', with: user_no_team.password
          click_button 'ログイン'
        end
        it 'チーム一覧にアクセスできること' do
          visit teams_path
          expect(current_path).to eq teams_path
        end
        it 'チーム作成ページにアクセスできること' do
          click_link('チーム作成')
          expect(current_path).to eq new_team_path
        end
        it 'チーム作成できること' do
          visit new_team_path
          fill_in 'チーム名', with: "test1"    
          fill_in 'チーム認証ID', with: "test1"
          click_button 'チームを作成する' 
          expect(page).to have_content 'チームを作成しました。'
        end
        it 'チーム認証画面にアクセスできる' do
          visit teams_path
          binding.pry
          click_link('このチームに参加する')
        end

      end
    end
  end
end

  