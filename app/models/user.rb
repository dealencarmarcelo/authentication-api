class User < ApplicationRecord
    has_secure_password

    validates_presence_of :fullname, :surname, :email, :password_digest

    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates_uniqueness_of :email, case_sensitive: false
end