class Reward < ApplicationRecord
  belongs_to :user
  validates :name, :issued_at, presence: true
end
