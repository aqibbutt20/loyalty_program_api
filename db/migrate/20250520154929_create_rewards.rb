class CreateRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :rewards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :description, null: false
      t.string :reward_type, null: false
      t.datetime :issued_at, null: false
      t.jsonb :metadata, default: {}

      t.timestamps
    end
  end
end
