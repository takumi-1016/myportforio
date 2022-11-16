require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'モデルのテスト' do
    it '有効なteamの場合は保存されること' do
      expect(build(:team)).to be_valid
    end

    context '空白のバリデーションチェック' do
      it 'team_nameが空白の場合にエラーメッセージが返ってくること' do
        team = build(:team, team_name: nil)
        team.valid?
        expect(team.errors[:team_name]).to include('を入力してください')
      end
      it 'certification_idが空白の場合にエラーメッセージが返ってくること' do
        team = build(:team, certification_id: nil)
        team.valid?
        expect(team.errors[:certification_id]).to include('を入力してください')
      end
    end
    it 'team_nameの文字数が20文字以上の場合エラーメッセージが返ってくること' do
      team = build(:team, team_name: '1111111111111111111111')
      team.valid?
      expect(team.errors[:team_name]).to include('は20文字以内で入力してください')
    end

    context '一意性制約の確認' do
      before do
        @team = build(:team)
      end

      it '同じteam_nameの場合エラーメッセージが返ってくること' do
        @team.save
        another_team = build(:team)
        another_team.team_name = @team.team_name
        another_team.valid?
        expect(another_team.errors[:team_name]).to include('はすでに存在します')
      end
      it '同じcertification_idの場合エラーメッセージが返ってくるか' do
        @team.save
        another_team = build(:team)
        another_team.certification_id = @team.certification_id
        another_team.valid?
        expect(another_team.errors[:certification_id]).to include('はすでに存在します')
      end
    end
  end
end
