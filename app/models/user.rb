class User < ActiveRecord::Base

    # authentication
    before_save {self.email = email.downcase}
    
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :username, presence: true,
              uniqueness: {case_sensitive: false},
              length: {minimum: 3, maximum: 25}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,
              length: {maximum: 100},
              uniqueness: {case_sensitive: false},
              format: {with: VALID_EMAIL_REGEX}
    has_secure_password
    
    validates :password_confirmation, presence: true;

    # projects
    has_many :project
end
