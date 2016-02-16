class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.text :desc
      t.boolean :active

      t.timestamps null: false
    end
    add_index :teams, :name, unique: true
  end
end
