class User < ApplicationRecord
    has_secure_password

    validates_presence_of :fullname, :surname, :email, :password_digest
end
