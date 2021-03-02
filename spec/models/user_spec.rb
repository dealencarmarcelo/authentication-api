require 'rails_helper'
require 'shoulda/matchers'

describe User, type: :model do

    it { should validate_presence_of(:fullname) }
    it { should validate_presence_of(:surname) }

    it { should validate_presence_of(:email) }
    it { should allow_values('example@email.com', 'email@validemail.com.br', 'email-with_symbol.@email.com').for(:email) }
    it { should_not allow_values('email.example.br', 'example@email@test.com').for(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password_digest).is_at_least(6) }
    
end