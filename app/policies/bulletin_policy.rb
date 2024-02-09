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
    record.published? || (record.creator_id == user.id)
  end

  def edit?
    record.creator_id == user.id
  end

  def update?
    record.creator_id == user.id
  end

  def to_moderate?
    record.creator_id == user.id
  end

  def archive?
    user.admin? || (record.creator_id == user.id)
  end

  def publish?
    user.admin? && record.may_publish?
  end

  def reject?
    user.admin?
  end
end
