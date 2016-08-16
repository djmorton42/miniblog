class User < ActiveRecord::Migration
    def change
        create_table :users do |t|
            t.string :email, null: false
            t.string :password_hash, null: false
            t.string :name, null: false
            t.datetime :last_login
            t.timestamps
        end
    end
end
