class CreateTopics < ActiveRecord::Migration[8.0]
  def change
    create_table :topics do |t|
      t.references :lesson, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content
      t.string :video_url
      t.integer :position
      t.string :slug, null: false, index: { unique: true }
      
      t.timestamps
    end
  end
end
