class User < ApplicationRecord
    has_many :posts, :dependent => :destroy
    has_many :comments, :dependent => :destroy
    has_secure_password
    validates :name, length: { minimum: 2 }
    validates :password, length: { minimum: 6 }
    validates :email, uniqueness: true, length: { minimum: 5 }
end