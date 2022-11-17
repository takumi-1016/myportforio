class CreateTagRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_relationships do |t|
      t.references :post_title, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tag_relationships, [:post_title_id, :tag_id], unique: true
  end
end
