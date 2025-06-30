class CreateLessons < ActiveRecord::Migration[8.0]
  def change
    create_table :lessons do |t|
      t.references :section, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content
      t.integer :position, null: false, default: 0
      t.boolean :published, null: false, default: true
      t.datetime :published_at
      t.integer :duration, null: false, default: 0 # Duration in seconds
      t.timestamps
    end
  end
end
