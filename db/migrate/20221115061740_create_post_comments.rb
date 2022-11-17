class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.text :comment, null: false
      t.references :user, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :post_title, null: false, foreign_key: true
      t.boolean :private, :default => false
      t.timestamps
    end
  end
end
