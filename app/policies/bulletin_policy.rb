# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    user
  end

  def create?
    user
  end

  def show?
    user && (record.published? || (record.user_id == user.id) || user.admin?)
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

  def publish?
    user && (user.admin? && record.may_publish?)
  end

  def reject?
    user&.admin?
  end
end
