class Bulletin < ApplicationRecord
  include AASM

  belongs_to :category
  belongs_to :creator, class_name: 'User', inverse_of: :bulletins

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  # validates :image, presence: true,
  #                   content_type: %i[png jpg jpeg],
  #                   size: { less_than: 5.megabytes }

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
      transitions from: [:draft, :under_moderation, :published, :rejected], to: :archived
    end
  end
end
