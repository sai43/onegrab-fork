class CreateEnrollments < ActiveRecord::Migration[8.0]
  def change
    create_table :enrollments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.string :status, null: false, default: "active"
      t.integer :progress, default: 0
      t.datetime :enrolled_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :completed_at  # Nullable, to be set when the course is completed
      t.datetime :canceled_at   # Nullable, to be set when the enrollment is canceled
      t.datetime :started_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :last_accessed_at  # Nullable, to track the last time the user accessed the course
      t.string :enrollment_type, null: false, default: "standard"  # e.g., standard, audit, credit
      t.string :payment_status, null: false, default: "unpaid"  # e.g., unpaid, paid, refunded
      t.decimal :amount_paid, precision: 10, scale: 2, default: 0.0  # Amount paid for the enrollment, if applicable
      t.string :currency, null: false, default: "INR"  # Currency for the amount paid, defaulting to INR
      t.string :enrollment_source, null: false, default: "web"  # e.g., web, mobile, API
      t.string :enrollment_code # Unique code for the enrollment, if applicable
      t.string :notes  # Nullable, for any additional notes related to the enrollment
      t.string :referral_code  # Nullable, to track any referral code used during enrollment
      t.string :referral_source  # Nullable, to track the source of the referral, if applicable
      t.string :utm_source  # Nullable, to track UTM parameters for marketing purposes
      t.string :utm_medium  # Nullable, to track UTM parameters for marketing purposes
      t.string :utm_campaign  # Nullable, to track UTM parameters for marketing purposes
      t.string :utm_content  # Nullable, to track UTM parameters for marketing purposes
      t.string :utm_term  # Nullable, to track UTM parameters for marketing purposes
      t.timestamps
    end
  end
end
a