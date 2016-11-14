class RemoveHashedpassFromStaffMembers < ActiveRecord::Migration
  def change
    remove_column :staff_members, :hashed_password, :string
  end
end
