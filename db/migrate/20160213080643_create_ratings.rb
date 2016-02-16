class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.decimal :happy_level 
      t.date :recorded 
      t.timestamps null: false
    end
  end
end
