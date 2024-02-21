# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, foreign_key: :user, inverse_of: :user, dependent: :destroy
  validates :email, presence: true, uniqueness: true
end
