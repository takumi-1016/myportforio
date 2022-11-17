require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'モデルのテスト' do
    it '有効なtagの場合は保存されること' do
      expect(build(:tag)).to be_valid
    end
    it 'nameの文字数が10文字以上の場合エラーメッセージが返ってくること' do
      tag = build(:tag, name: '111111111111111')
      tag.valid?
      expect(tag.errors[:name]).to include('は10文字以内で入力してください')
    end
  end
end
