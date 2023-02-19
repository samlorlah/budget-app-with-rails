class Group < ApplicationRecord
  validates :name, presence: true, length: { in: 1..15 },
                   uniqueness: { scope: :author, message: 'You already have a category with this name' }
  validates :icon, presence: true, length: { in: 1..150 }

  belongs_to :author, class_name: 'User'
end
