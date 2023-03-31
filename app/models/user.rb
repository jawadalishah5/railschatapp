class User < ApplicationRecord
    validates_uniqueness_of :username
    
    def self.generate

        number = rand.to_s[2..6]
        username = "User-#{number}"
        create(username: username)
    end
end
