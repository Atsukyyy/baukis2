class AddPassToStaffMembers < ActiveRecord::Migration
  def change
    add_column :staff_members, :hashed_password, :string
  end
end
