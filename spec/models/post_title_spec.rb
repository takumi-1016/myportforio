require 'rails_helper'

RSpec.describe PostTitle, type: :model do
  let(:post_title) { create(:post_title) }

  it '有効なpost_titleの場合は保存されること' do
    expect(post_title).to be_valid
  end

  it 'user_idがない場合、無効であること' do
    post_title.user_id = nil
    expect(post_title).to be_invalid
  end

  it 'team_idがない場合、無効であること' do
    post_title.team_id = nil
    expect(post_title).to be_invalid
  end

  it 'タイトルがない場合、無効であること' do
    post_title.title = nil
    expect(post_title).to be_invalid
    expect(post_title.errors[:title]).to include('を入力してください')
  end
end
