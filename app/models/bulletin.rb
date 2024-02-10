# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  belongs_to :category
  belongs_to :user, class_name: 'User', inverse_of: :bulletins

  has_one_attached :image

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, presence: true,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 5.megabytes }

  aasm column: 'state' do
    state :draft, initial: true
    state :under_moderation, :published, :rejected, :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[title category_id state]
  end
end
