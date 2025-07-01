class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :rating
      t.text :content
      t.string :status, default: "pending"

      t.timestamps
    end
    add_index :comments, :status
  end
end
