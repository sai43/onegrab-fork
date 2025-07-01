class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :content, presence: true, length: { minimum: 5 }
  validates :rating, numericality: { only_integer: true, in: 1..5 }, allow_nil: true

  enum :status, { pending: "pending", approved: "approved", hidden: "hidden" }, default: :pending
end
