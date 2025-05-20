class CreateRewardRedemptions < ActiveRecord::Migration[7.1]
  def change
    create_table :reward_redemptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reward, null: false, foreign_key: true
      t.integer :points_spent, null: false
      t.datetime :redeemed_at, null: false

      t.timestamps
    end

    add_index :reward_redemptions, [:user_id, :reward_id]
  end
end
