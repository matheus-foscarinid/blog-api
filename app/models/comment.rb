class Comment < ApplicationRecord
    belongs_to :post
    validates :text, length: { minimum: 5 }
end