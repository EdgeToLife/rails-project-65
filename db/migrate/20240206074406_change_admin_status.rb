class ChangeAdminStatus < ActiveRecord::Migration[7.1]
  def change
    user = User.find_by(email: 'zhuko-ivan@yandex.ru')
    user.update(admin: true) if user.present?
  end
end
