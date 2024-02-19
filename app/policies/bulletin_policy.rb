# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    record.published? || (user.present? && (record.user_id == user.id || user.admin?))
  end

  def edit?
    user && (record.user_id == user.id)
  end

  def update?
    user && (record.user_id == user.id)
  end

  def to_moderate?
    user && (record.user_id == user.id)
  end

  def archive?
    user && (user.admin? || (record.user_id == user.id))
  end
end
