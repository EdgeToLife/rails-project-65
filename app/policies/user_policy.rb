class UserPolicy
  attr_reader :current_user

  def initialize(current_user, user)
    @current_user = current_user
    @user = user
  end

  def access_admin_panel?
    @user.admin?
  end
end
