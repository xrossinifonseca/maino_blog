class CreatePost < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.references :customer, null: false, foreign_key: true
      t.timestamps
    end
  end
end
