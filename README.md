# Loyalty Program API

A Rails-based API for managing customer loyalty points and rewards.

## Setup

1. **Requirements**: Ruby 3.3.3, PostgreSQL, Rails 7.1
2. Install dependencies: `bundle install`
3. Setup database: `rails db:create db:migrate db:seed`
4. Run the server: `rails s`

## Key Features

- **Points Calculation**:
  - 10 points per $100 spent
  - 2x points for foreign transactions

- **Automatic Rewards**:
  - Free Coffee when reaching 100+ points/month
  - Birthday month Free Coffee
  - Free Movie Tickets for new users spending >$1000 in 60 days

## API Usage

```bash
# Create user
POST /users
{ "user": { "name": "Test User", "email": "test@example.com", "birthday": "YYYY-MM-DD" } }

# Create transaction
POST /users/:user_id/transactions
{ "transaction": { "amount": 150, "country": "US", "occurred_at": "ISO8601" } }

# View rewards
GET /users/:user_id/rewards
```

## Testing

Run the full suite with:

```
bundle exec rspec
```

### Future Considerations

The foundation supports easy addition of:
- Tiered loyalty levels (Gold/Platinum)
- Point expiration logic
- Quarterly bonus points
- Custom reward rules

Authentication uses simple API key auth (X-API-Key header), ready for extension to JWT if needed.
