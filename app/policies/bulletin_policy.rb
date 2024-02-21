# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    record.published? || owner? || user&.admin?
  end

  def edit?
    user && owner?
  end

  def update?
    user && owner?
  end

  def to_moderate?
    user && owner?
  end

  def archive?
    user && (user.admin? || owner?)
  end

  def owner?
    record.user_id == user&.id
  end
end
