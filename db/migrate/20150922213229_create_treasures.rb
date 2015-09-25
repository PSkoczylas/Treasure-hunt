class CreateTreasures < ActiveRecord::Migration
  def change
    create_table :treasures do |t|
      t.string :email
      t.boolean :is_winner

      t.timestamps null: false
    end
  end
end
