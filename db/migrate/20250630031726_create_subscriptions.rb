class CreateSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :currency, null: false, default: 'INR'
      t.string :status, null: false, default: 'pending'
      t.datetime :started_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :ends_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :trial_starts_at
      t.datetime :trial_ends_at
      t.datetime :suspended_at
      t.datetime :canceled_at
      t.string :cancel_reason
      t.string :payment_method, null: false, default: 'cash'
      t.string :external_id

      t.timestamps
    end
  end
end
