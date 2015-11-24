class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|

      t.string :letter, null: false
      t.integer :game_id, null: false, index: true
      t.references :game

      t.timestamps null: false
    end
  end
end
