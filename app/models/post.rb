class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: true
end
