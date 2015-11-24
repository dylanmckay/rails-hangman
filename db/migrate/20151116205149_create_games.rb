class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :target_word, null: false
      t.integer :user_id, null: false, index: true
      t.references :user

      t.timestamps null: false
    end
  end
end
