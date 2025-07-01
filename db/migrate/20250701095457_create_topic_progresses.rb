class CreateTopicProgresses < ActiveRecord::Migration[8.0]
  def change
    create_table :topic_progresses do |t|
      t.references :enrollment, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true

      t.boolean :completed, default: false, null: false
      t.datetime :started_at
      t.datetime :completed_at

      t.timestamps
    end

    add_index :topic_progresses, [:enrollment_id, :topic_id], unique: true
  end
end
