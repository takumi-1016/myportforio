require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'モデルのテスト' do
    it '有効なuserの場合は保存されること' do
      expect(build(:user)).to be_valid
    end

    context '空白のバリデーションチェック' do
      it 'user_nameが空白の場合にエラーメッセージが返ってくること' do
        user = build(:user, user_name: nil)
        user.valid?
        expect(user.errors[:user_name]).to include('を入力してください')
      end
      it 'emailが空白の場合にエラーメッセージが返ってくること' do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include('を入力してください')
      end
      it 'passwordが空白の場合にエラーメッセージが返ってくること' do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include('を入力してください')
      end
    end

    it 'user_nameの文字数が15文字以上の場合エラーメッセージが返ってくること' do
      user = build(:user, user_name: 'aaaaaaaaaaaaaaaaa')
      user.valid?
      expect(user.errors[:user_name]).to include('は15文字以内で入力してください')
    end

    context '一意性制約の確認' do
      before do
        @user = build(:user)
      end

      it '同じuser_nameの場合エラーメッセージが返ってくること' do
        @user.save
        another_user = build(:user)
        another_user.user_name = @user.user_name
        another_user.valid?
        expect(another_user.errors[:user_name]).to include('はすでに存在します')
      end
      it '同じemailの場合エラーメッセージが返ってくるか' do
        @user.save
        another_user = build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors[:email]).to include('はすでに存在します')
      end
    end
  end
end
