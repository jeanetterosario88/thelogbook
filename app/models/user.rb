class User < ActiveRecord::Base
    has_secure_password
    has_many :entries

    validates :username,
          presence: true,
          length: { minimum: 4, maximum: 16 },
          uniqueness: true

    validates :email 
        presence: true

    validates :password, 
          presence: true


end