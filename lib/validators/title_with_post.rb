module Validators
    class TitleWithPost <ActiveModel::Validator
        def validate(record)
            unless record.title.starts_with? 'POST'
                record.errors[:title] << 'Need a title starting with POST, please'
            end
        end
    end
end