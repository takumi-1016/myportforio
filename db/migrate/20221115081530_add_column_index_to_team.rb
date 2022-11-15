class AddColumnIndexToTeam < ActiveRecord::Migration[6.1]
  def change
    add_index :teams, :team_name, unique: true
  end
end
