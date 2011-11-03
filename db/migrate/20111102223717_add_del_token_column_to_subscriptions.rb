class AddDelTokenColumnToSubscriptions < ActiveRecord::Migration
  def change
    change_table :subscriptions do |t|
      t.string :del_token
    end
  end
end
