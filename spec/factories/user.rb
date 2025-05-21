FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "user#{n}@example.com" }
    birthday { Faker::Date.between(from: 30.years.ago, to: 18.years.ago) }

    trait :birthday_month do
      birthday { Date.current.beginning_of_month + rand(1..28).days }
    end

    trait :new_user do
      created_at { Time.current - 7.days }
    end

    trait :with_transactions do
      transient do
        transactions_count { 3 }
        amount { 100 }
      end

      after(:create) do |user, evaluator|
        create_list(:transaction, evaluator.transactions_count, 
                   user: user, 
                   amount: evaluator.amount)
      end
    end
  end
end
