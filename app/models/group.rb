class Group < ApplicationRecord
  validates :groupname, presence: true
  has_many :members
  has_many :users, through: :members

end
