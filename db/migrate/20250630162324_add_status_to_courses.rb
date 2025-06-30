class AddStatusToCourses < ActiveRecord::Migration[8.0]
  def change
    add_column :courses, :status, :string, default: "draft", null: false
    add_index :courses, :status
  end
end
