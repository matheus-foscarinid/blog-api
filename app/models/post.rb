class Post < ApplicationRecord
    has_many :comments
    belongs_to :user
    has_and_belongs_to_many :tags, before_add: :check_tag

    validates :title, length: { in: 1..100 }, uniqueness: true, exclusion: {in: %w(god jesus admin)}
    validates :description, length: { minimum: 10 }

    #validates_with Validators::TitleWithPost

    private 

    def check_tag tag
        # raise ActiveRecord::Rollback if self.tags.include?(tag)
        raise ActiveRecord::RecordNotUnique, "tag #{tag.id} already been used" if self.tags.include?(tag)
    end
end