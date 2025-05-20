User.destroy_all

user = User.create!(
  name: "Test User",
  email: "test@example.com",
  birthday: Date.current - 30.years
)

transactions = [
  { amount: 1000, country: "US", occurred_at: 1.day.ago },
  { amount: 500, country: "JP", occurred_at: 2.days.ago },
  { amount: 200, country: "US", occurred_at: 3.days.ago }
]

transactions.each do |t|
  user.transactions.create!(t)
end

puts "Seeded user with #{user.transactions.count} transactions"
