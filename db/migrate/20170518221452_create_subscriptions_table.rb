class CreateSubscriptionsTable < ActiveRecord::Migration
    def change
        create_table :subscriptions do |t|
            t.string :email, null: false
            t.boolean :confirmed
            t.string :confirm_token
            t.string :unsubscribe_token
            t.timestamps
        end
    end
end
