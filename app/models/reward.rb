class Reward < ApplicationRecord
  belongs_to :user
  has_many :reward_redemptions, dependent: :destroy

  validates :name, :description, :reward_type, :issued_at, presence: true
end
