class Bulletin < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: 'User', inverse_of: :bulletins

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  # validates :image, presence: true,
  #                   content_type: %i[png jpg jpeg],
  #                   size: { less_than: 5.megabytes }
end
