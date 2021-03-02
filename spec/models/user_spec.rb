require 'rails_helper'
require 'shoulda/matchers'

describe User, type: :model do
    
    it { should validate_presence_of(:fullname) }
    it { should validate_presence_of(:surname) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }

end