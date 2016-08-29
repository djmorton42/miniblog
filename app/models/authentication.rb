require 'bcrypt'

class LoginValidator < ActiveModel::Validator
    include BCrypt
    
    def validate(record)
        user = User.find_by_email(record.email)
        if user.nil?
            record.errors[:email] << 'Email could not be found or password was not correct!'
        else
            if Password.new(user.password_hash) != record.password
                record.errors[:password] << 'Email could not be found or password was not corect!'
            end
        end
    end
end

class Authentication
    include ActiveModel::Validations      
    include ActiveModel::Conversion       
    #include ActiveModel::SerializerSupport
    include BCrypt
    extend ActiveModel::Naming            
                                                
    validates :email, presence: { message: "Email is required" }, email: { message: "Must be a validly formatted email address" }
    validates :password, presence: { message: "Password is required" }
    validates_with LoginValidator
    
    def initialize(options = {})
        self.email = options[:email]
        self.password = options[:password]
    end
    
    def self.create(options = {})
        authentication = Authentication.new(options)
        
        if authentication.valid?
            authentication.user = User.where(email: authentication.email).first
        end
        
        return authentication
    end
    
    attr_accessor :email
    attr_accessor :password
    attr_accessor :user

end
