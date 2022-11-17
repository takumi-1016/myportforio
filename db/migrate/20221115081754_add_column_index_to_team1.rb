class AddColumnIndexToTeam1 < ActiveRecord::Migration[6.1]
  def change
    add_index :teams, :certification_id, unique: true
  end
end
