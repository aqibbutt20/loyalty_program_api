class CreateRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :rewards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.datetime :issued_at, null: false

      t.timestamps
    end
  end
end
