class RemoveLimitsFromBulletins < ActiveRecord::Migration[7.1]
  def change
    change_column :bulletins, :title, :string, limit: nil
    change_column :bulletins, :description, :text, limit: nil
  end
end
