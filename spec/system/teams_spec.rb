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
end
