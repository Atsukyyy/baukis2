class RemovePassCofirmFromStaffMembers < ActiveRecord::Migration
  def change
    remove_column :staff_members, :password_confirmation, :string
  end
end
