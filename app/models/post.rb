class Post < ApplicationRecord
    has_many :comments
    validates :title, length: { in: 1..100 }, uniqueness: true, exclusion: {in: %w(god jesus admin)}
    validates :description, length: { minimum: 10 }
    #validates_with Validators::TitleWithPost
end