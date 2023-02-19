class Expense < ApplicationRecord
  validates :name, presence: true, length: { in: 1..50 },
                   uniqueness: { scope: :author, message: 'You already have a transaction with this name' }
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :author, class_name: 'User'
end
