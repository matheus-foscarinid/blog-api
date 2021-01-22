class Comment < ApplicationRecord
    belongs_to :post
    belongs_to :user
    validates :text, length: { minimum: 5 }
end