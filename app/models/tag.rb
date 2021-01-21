class Tag < ApplicationRecord
    validates :name, length: { in: 3..20 }, uniqueness: true
end
