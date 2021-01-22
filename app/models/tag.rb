class Tag < ApplicationRecord
    has_and_belongs_to_many :posts
    validates :name, length: { in: 3..20 }, uniqueness: true
end