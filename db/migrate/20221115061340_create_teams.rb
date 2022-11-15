class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :team_name, null: false 
      t.text :team_profile
      t.string :certification_id, null: false 
      t.timestamps
    end
  end
end
