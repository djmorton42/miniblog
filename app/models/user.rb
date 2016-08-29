require 'bcrypt'

class User < ActiveRecord::Base
    include BCrypt

    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, uniqueness: true, length: { maximum: 100 }
    validates :password, presence: true, confirmation: true, length: { in: 6..200 }

    def password
        @password ||= Password.new(password_hash)
    end

    def password=(new_password)
        @password = Password.create(new_password)
        self.password_hash = @password
    end
end
