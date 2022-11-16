class AddColumnIndexToLike < ActiveRecord::Migration[6.1]
  def change
    add_index :likes, [:post_comment_id, :user_id], unique: true
  end
end
