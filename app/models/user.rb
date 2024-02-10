# frozen_string_literal: true

class User < ApplicationRecord
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.name = auth['info']['name']
      user.email = auth['info']['email']
    end
  end
  has_many :bulletins, foreign_key: :user, inverse_of: :user, dependent: :destroy
end
