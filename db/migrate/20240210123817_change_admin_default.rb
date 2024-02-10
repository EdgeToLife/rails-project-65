class ChangeAdminDefault < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :admin, true
  end
end
