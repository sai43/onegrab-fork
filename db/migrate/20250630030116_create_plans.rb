class CreatePlans < ActiveRecord::Migration[8.0]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.index :slug, unique: true
      t.text :description
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :currency, default: 'INR'
      t.string :interval, default: 'monthly'
      t.integer :interval_count, default: 1
      t.integer :duration_days, null: false, default: 30
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
