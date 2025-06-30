class CreateSections < ActiveRecord::Migration[8.0]
  def change
    create_table :sections do |t|
      t.references :course, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :position, null: false, default: 0
      t.text :description
      t.integer :duration, null: false, default: 0 # Duration in seconds
      t.boolean :published, null: false, default: true 
      t.datetime :published_at
      t.timestamps
    end
  end
end
