class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.int :flight_id
      t.int :user_id

      t.timestamps
    end
  end
end
