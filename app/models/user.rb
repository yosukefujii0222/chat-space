class User < ApplicationRecord
  has_many :members
  has_many :groups, through: :members
  has_many :messages
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
