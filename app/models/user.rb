require 'bcrypt'

class User < ActiveRecord::Base
    include BCrypt

    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, uniqueness: true, length: { maximum: 100 }
    validates :input_password, presence: true, confirmation: true, length: { in: 6..200 }
    validates :input_password_confirmation, presence: true

    def input_password
      @input_password 
    end

    def input_password=(new_password)
      @input_password = new_password
      self.password = new_password
    end

    def password
       @password ||= Password.new(password_hash)
    end

    def password=(new_password)
        @password = Password.create(new_password)
        self.password_hash = @password
    end

    attr_accessor :input_password_confirmation
end
