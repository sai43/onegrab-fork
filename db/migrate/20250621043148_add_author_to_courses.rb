class AddAuthorToCourses < ActiveRecord::Migration[8.0]
  def change
    add_reference :courses, :author, null: false, foreign_key: { to_table: :users }
  end
end
