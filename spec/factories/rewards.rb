FactoryBot.define do
  factory :reward do
    user
    name { ['Free Coffee', 'Free Movie Tickets', '5% Cash Rebate'].sample }
    issued_at { Time.current }

    trait :coffee do
      name { 'Free Coffee' }
    end

    trait :movie_tickets do
      name { 'Free Movie Tickets' }
    end
  end
end
