require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = FactoryBot.build(:like)
  end
  describe '正常値と異常値の確認' do
    context 'likeモデルのバリデーション' do
      it 'user_idとpost_comment_idがあれば保存できる' do
        expect(FactoryBot.create(:like)).to be_valid
      end

      it 'user_idがなければ無効な状態であること' do
        @like.user_id = nil
        @like.valid?
        expect(@like.errors[:user_id]).to include('を入力してください')
      end

      it 'post_comment_idがなければ無効な状態であること' do
        @like.post_comment_id = nil
        @like.valid?
        expect(@like.errors[:post_comment_id]).to include('を入力してください')
      end

      it 'post_comment_idが同じでもuser_idが違うと保存できる' do
        like = FactoryBot.create(:like)
        expect(FactoryBot.create(:like, post_comment_id: like.post_comment_id)).to be_valid
      end

      it 'user_idが同じでもpost_comment_idが違うと保存できる' do
        like = FactoryBot.create(:like)
        expect(FactoryBot.create(:like, user_id: like.user_id)).to be_valid
      end
    end
  end
end
