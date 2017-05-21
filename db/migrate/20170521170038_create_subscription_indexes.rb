class CreateSubscriptionIndexes < ActiveRecord::Migration
    def change
        add_index :subscriptions, :email
        add_index :subscriptions, :confirmed
        add_index :subscriptions, :unsubscribe_token, unique: true
        add_index :subscriptions, :confirm_token, unique: true
    end
end
