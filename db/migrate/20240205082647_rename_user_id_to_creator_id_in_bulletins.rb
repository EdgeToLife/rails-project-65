class RenameUserIdToCreatorIdInBulletins < ActiveRecord::Migration[7.1]
  def change
    rename_column :bulletins, :users_id, :creator_id
  end
end
