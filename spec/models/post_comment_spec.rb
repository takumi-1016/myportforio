require 'rails_helper'

RSpec.describe PostComment, type: :model do
  let(:post_comment) { create(:post_comment) }

  it '有効なpost_commentの場合は保存されること' do
    expect(post_comment).to be_valid
  end

  it 'user_idがない場合、無効であること' do
    post_comment.user_id = nil
    expect(post_comment).to be_invalid
  end

  it 'team_idがない場合、無効であること' do
    post_comment.team_id = nil
    expect(post_comment).to be_invalid
  end

  it 'post_title_idがない場合、無効であること' do
    post_comment.post_title_id = nil
    expect(post_comment).to be_invalid
  end

  it 'タイトルがない場合、無効であること' do
    post_comment.comment = nil
    expect(post_comment).to be_invalid
    expect(post_comment.errors[:comment]).to include('を入力してください')
  end
end
