FactoryBot.define do
  factory :transaction do
    user
    amount { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    country { ['US', 'JP', 'SG', 'UK'].sample }
    occurred_at { Faker::Time.between(from: 1.year.ago, to: Time.current) }

    trait :domestic do
      country { 'US' }
    end

    trait :foreign do
      country { 'JP' }
    end

    trait :recent do
      occurred_at { Time.current - rand(1..30).days }
    end

    trait :large_amount do
      amount { 1000 }
    end
  end
end
