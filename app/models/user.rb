class User < ApplicationRecord
    has_secure_password

    validates_presence_of :fullname, :surname, :email
    validates :password_digest, presence: true, length: { minimum: 6 }

    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates_uniqueness_of :email, case_sensitive: false
end