class Article < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :articles

  validates :preview, uniqueness: true, presence: true
end
