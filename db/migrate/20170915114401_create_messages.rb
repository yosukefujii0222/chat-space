class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body, null: false, foreign_key: true
      t.integer :user_id, null: false, foreign_key:true
      t.integer :group_id, null: false, foreign_key:true
      t.text :image
      t.timestamps null: false
    end
  end
end
