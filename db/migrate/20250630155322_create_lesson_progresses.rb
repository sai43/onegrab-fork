class CreateLessonProgresses < ActiveRecord::Migration[8.0]
  def change
    create_table :lesson_progresses do |t|
      t.references :enrollment, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.integer :status, default: 0, null: false  # 0: incomplete, 1: completed
      t.datetime :started_at
      t.datetime :completed_at
      t.integer :progress, null: false, default: 0
      t.text :notes
      t.integer :duration, null: false, default: 0 # Duration in seconds
      t.boolean :published, null: false, default: true
      t.datetime :published_at
      t.timestamps
    end
  end
end
