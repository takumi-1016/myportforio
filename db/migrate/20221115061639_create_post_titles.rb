class CreatePostTitles < ActiveRecord::Migration[6.1]
  def change
    create_table :post_titles do |t|
      t.string :title, null: false
      t.references :user, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
