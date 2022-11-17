require 'rails_helper'

RSpec.describe TagRelationship, type: :model do
  let(:tag_relationship) { create(:tag_relationship) }

  it 'post_title_idとtag_idがある場合、有効であること' do
    expect(tag_relationship).to be_valid
  end

  it 'post_title_idがない場合、無効であること' do
    tag_relationship.post_title_id = nil
    expect(tag_relationship).to be_invalid
  end

  it 'tag_idがない場合、無効であること' do
    tag_relationship.tag_id = nil
    expect(tag_relationship).to be_invalid
  end
end
