class Reward < ApplicationRecord
  belongs_to :user

  validates :name, :issued_at, presence: true

  scope :coffee, -> { where(name: 'Free Coffee') }
  scope :movie_tickets, -> { where(name: 'Free Movie Tickets') }
end
