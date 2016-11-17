class RemovePassFromStaffMembers < ActiveRecord::Migration
  def change
    remove_column :staff_members, :password, :string
  end
end
